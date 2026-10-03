# 📋 Protocolo de Triagem e Coleta Antropométrica Pélvica
> Procedimento operacional padrão para extração de medidas anatômicas e alimentação do script paramétrico `pelve_psicometrica.scad`.

---

## 1. Instrumentação Mínima Recomendada
* **Paquímetro Antropométrico de Grandes Diâmetros** (ou compasso de espessura de 50–60 cm).
* **Fita métrica antropométrica inextensível** (fibra de vidro ou aço flexível).
* **Régua rígida de alinhamento** (30 a 50 cm).
* **Lápis dermográfico ou adesivos hipoalergênicos** para demarcação cutânea.

---

## 2. Preparação do Residente
1. **Ambiente e Acolhimento:** Explicar o procedimento de forma clara e acessível, garantindo um ambiente aquecido e calmo para reduzir disparos espásticos ou elevação involuntária do tônus muscular.
2. **Posicionamento Padrão:**
   * Residente posicionado sentado em superfície firme (ou na própria cadeira de rodas devidamente nivelada).
   * Ângulo aproximado de 90° de flexão em quadris, joelhos e tornozelos.
   * Em casos de assimetria severa ou hipotonia acentuada de tronco, solicitar o auxílio de um segundo profissional para estabilização postural momentânea.

---

## 3. Identificação e Palpação dos Marcos Ósseos
Palpar e marcar suavemente na pele (ou sobre malha justa de algodão/lycra):
* **EIAS (Espinhas Ilíacas Ântero-Superiores):** Proeminências ósseas anteriores salientes na linha da cintura.
* **EIPS (Espinhas Ilíacas Póstero-Superiores):** Projeções sacrais posteriores (covinhas da região lombo-sacra).
* **Cristas Ilíacas:** Borda superior curva dos ossos ilíacos.
* **Trocânteres Maiores:** Saliências ósseas laterais no topo dos fêmures.

---

## 4. Tabela de Mapeamento: Medidas Clínicas ➔ Variáveis no OpenSCAD

| Medida Anatômica | Como Medir | Variável no Código (`.scad`) | Unidade | Folga Técnica Recomendada (*Offset*) |
| :--- | :--- | :--- | :--- | :--- |
| **Largura Bi-ilíaca Anterior** | Distância linear entre os ápices da EIAS esquerda e direita com o paquímetro. | `largura_biiliaca` | mm | +5 mm a +10 mm (para acomodar EVA) |
| **Profundidade Sagital** | Distância do plano frontal da EIAS até o plano sacral posterior. | `profundidade_sagital` | mm | +5 mm de alívio cutâneo |
| **Altura da Crista Ilíaca** | Distância vertical da base do assento até a crista superior. | `altura_apoio` | mm | - |
| **Raio Anatômico da Crista** | Curvatura de contorno da crista ilíaca (estimada com gabarito ou molde). | `raio_curvatura` | mm | - |
| **Espessura Estrutural** | Espessura da parede da peça impressa em PETG. | `espessura_parede` | mm | Recomendado entre 6 mm e 8 mm |

---

## 5. Cuidados Éticos e Prevenção de Lesões
* **Distribuição de Pressão:** A interface plástica nunca deve ter contato direto com a epiderme. É obrigatória a aplicação de revestimento interno de espuma técnica (EVA de alta densidade ou Neoprene de 5 a 8 mm).
* **Triplicata:** Realizar cada medição 3 vezes consecutivas e utilizar a média aritmética para minimizar distorções causadas por espasmos musculares.
* **Anonimização de Dados:** Os relatórios antropométricos e arquivos gerados devem ser identificados exclusivamente por códigos numéricos (ex: `RES-01`), sem metadados com nomes dos residentes.