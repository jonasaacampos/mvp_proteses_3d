// ========================================================
// MVP v2 - SUPORTE PÉLVICO PARAMÉTRICO ROBUSTO (SEM ERRO DE MALHA)
// ========================================================

// Qual parte exportar para fatiar? 
// Opções: "esquerdo", "direito", "ambos"
modo_impressao = "esquerdo"; 

// --- Variáveis Antropométricas de Entrada (em mm) ---
largura_biiliaca     = 280; // Distância entre as EIAS
profundidade_sagital = 180; // EIAS até crista posterior
altura_apoio         = 80;  // Altura de contenção vertical
espessura_parede     = 6;   // Espessura sólida para PETG (reforçada)
raio_curvatura       = 40;  // Raio anatômico das cristas

$fn = 60; // Resolução das curvas

module aba_pelvica(lado="esquerdo") {
    sinal = (lado == "esquerdo") ? -1 : 1;
    
    difference() {
        // 1. Corpo Sólido Anatômico do Lado Selecionado
        hull() {
            // Apoio da Crista Ilíaca Anterior (EIAS)
            translate([sinal * (largura_biiliaca/2), 0, 0])
                cylinder(r=raio_curvatura + espessura_parede, h=altura_apoio, center=true);
                
            // Transição Lateral Posterior (abraça o quadril)
            translate([sinal * (largura_biiliaca/2 - 20), -profundidade_sagital * 0.7, 0])
                cylinder(r=raio_curvatura + espessura_parede - 2, h=altura_apoio, center=true);
                
            // Ancoragem Sacral Posterior (apoio de encosto)
            translate([sinal * 25, -profundidade_sagital, 0])
                cylinder(r=raio_curvatura + espessura_parede, h=altura_apoio, center=true);
        }
        
        // 2. Alívio Interno (Cavidade do Corpo + Folga de Almofada EVA)
        hull() {
            translate([sinal * (largura_biiliaca/2), 0, 0])
                cylinder(r=raio_curvatura, h=altura_apoio + 10, center=true);
                
            translate([sinal * (largura_biiliaca/2 - 20), -profundidade_sagital * 0.7, 0])
                cylinder(r=raio_curvatura - 2, h=altura_apoio + 10, center=true);
                
            translate([sinal * 25, -profundidade_sagital, 0])
                cylinder(r=raio_curvatura, h=altura_apoio + 10, center=true);
        }
        
        // 3. Fenda Frontal Reforçada para Cinta de Velcro (50 mm de largura)
        translate([sinal * (largura_biiliaca/2 + 5), 10, 0])
            cube([8, 52, 54], center=true);

        // 4. Fenda Posterior para Cinta Sacral / Acoplamento
        translate([sinal * 45, -profundidade_sagital, 0])
            cube([52, 8, 54], center=true);
            
        // 5. Furação Passante para Parafuso M6 (Fixação no Chassi Metálico)
        translate([sinal * (largura_biiliaca/2 - 15), -profundidade_sagital * 0.5, 0])
            rotate([0, 90, (lado == "esquerdo") ? 15 : -15])
                cylinder(r=3.2, h=80, center=true); // Diâmetro 6.4mm para parafuso M6
    }
}

// Renderização condicional
if (modo_impressao == "esquerdo") {
    // Centraliza o lado esquerdo na origem (perfeito para a placa de impressão)
    translate([largura_biiliaca/4, profundidade_sagital/2, 0])
        aba_pelvica("esquerdo");
} else if (modo_impressao == "direito") {
    // Centraliza o lado direito na origem
    translate([-largura_biiliaca/4, profundidade_sagital/2, 0])
        aba_pelvica("direito");
} else {
    // Ambos juntos
    aba_pelvica("esquerdo");
    aba_pelvica("direito");
}