# 19-tap FIR Filter — ASIC Front-end 합성

19-tap Low-Pass FIR 필터를 RTL로 설계하고, **SAED32 공정으로 합성하여 타이밍을 닫은**
ASIC Front-end 프로젝트입니다. 기능 설계는 시작일 뿐이고, 본질은 합성(Synthesis)과
타이밍 클로징에 있었습니다.

> **Tools** : Verilog · Synopsys Design Compiler · SAED32 (SS corner)
> **결과** : Setup Slack **+0.02ns** (MET) @ Clock 1.8ns

---

## 설계 구조 (Folded Symmetric FIR)

대칭 계수(B0–B9)를 활용한 폴딩 구조로 곱셈기 수를 절감했습니다.

### 1. 대칭 계수 폴딩 — [`rtl/top.v`](rtl/top.v)
B0~B9의 대칭성을 이용해 `d_xn + xn18` 형태로 입력을 먼저 더한 뒤(`adder1`-`adder10`)
곱셈하여, 덧셈기를 절반으로 접고 곱셈기 수를 줄였습니다.

```
계수: B0=6, B1=0, B2=-8, B3=-14, B4=-12, B5=0, B6=19, B7=41, B8=58, B9=64 (정중앙 최고값)
```

### 2. 풀정밀도 곱셈 + 파이프라인 — [`rtl/product_oneborn.v`](rtl/product_oneborn.v)
9-bit로 확장한 입력에 8-bit 계수를 곱해 **17-bit 풀정밀도 곱셈**을 수행합니다.
비트를 자르지 않고 그대로 전달하여 정밀도 손실을 방지했습니다.

### 3. 파이프라인 레지스터 — [`rtl/pipe_1.v`](rtl/pipe_1.v), [`rtl/pipe_2.v`](rtl/pipe_2.v)
덧셈 단(9-bit)과 곱셈 단(17-bit) 사이에 파이프라인 레지스터를 삽입해
타이밍 경로를 분할했습니다.

### 4. 가산 트리 + 반올림 + 클리핑 — [`rtl/top.v`](rtl/top.v)
곱셈 결과를 가산 트리로 누적하며 **17→19→20→21bit**로 확장합니다.
이후 `+128` 후 `>>8`(÷256) 반올림하고, signed 8-bit로 포화 클리핑하여 오버플로를 방지합니다.

```verilog
// 반올림: 256의 절반(128)을 더한 뒤 >>8
rounded_product_add = product_add_add_add_add2 + 21'sd128;
shift_product_add   = rounded_product_add[20:8];   // ÷256
// signed 8-bit 포화 클리핑
clipped_result = (상위비트 동일) ? 그대로 : (양수면 +127, 음수면 -128);
```

---

## 합성 결과 (Design Compiler)

| 항목 | 값 |
|------|-----|
| **Setup Slack** | **+0.02 ns (MET)** |
| Clock Period | 1.8 ns |
| Library | saed32 (SS corner) |
| Total Cell Area | 4,232.26 µm² |
| Total Area | 5,109.52 µm² |

**SDC 제약([`constraint/top.con`](constraint/top.con))을 직접 작성**하여 `create_clock`, `set_input/output_delay`,
`set_clock_uncertainty`, `set_clock_groups` 등을 정의하고, timing/area 리포트를 분석해 setup slack +0.02ns로
타이밍을 닫았습니다. 이 프로젝트의 핵심 기여는 **RTL 설계 + SDC 작성 + 타이밍 클로징**입니다.

### 기능 검증
제공된 Python 레퍼런스 모델의 출력(필터 계수 및 기댓값)을 기준으로,
top.v를 거친 Verilog 출력이 동일하게 나오는지 3,000 샘플에 대해 비교하여 기능 정합성을 확인했습니다.

---

## 파일 구성

| 파일 | 역할 |
|------|------|
| `rtl/top.v` | FIR 톱 모듈 — 폴딩 덧셈, 가산 트리, 반올림/클리핑 |
| `rtl/product_oneborn.v` | 파라미터화된 곱셈기 (17-bit 풀정밀도) |
| `rtl/pipe_1.v` | 덧셈 단 파이프라인 레지스터 (9-bit) |
| `rtl/pipe_2.v` | 곱셈 단 파이프라인 레지스터 (17-bit) |
| `rtl/d_ff.v` | 입력 지연용 D 플립플롭 |
| `constraint/top.con` | 직접 작성한 SDC 타이밍 제약 |

> 합성 스크립트, 합성 리포트(Design Compiler 산출물), 테스트벤치, Python 레퍼런스 모델(강의 제공)은
> 본 저장소에서 제외했습니다. 위 합성 결과 수치는 실제 리포트에서 확인한 값입니다.
