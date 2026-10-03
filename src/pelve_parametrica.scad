// ==========================================
// MVP - SUPORTE PÉLVICO PARAMÉTRICO DE BAIXO CUSTO
// ==========================================

// Variáveis Antropométricas de Entrada (em mm)
largura_biiliaca = 280;     // Distância EIAS-EIAS
profundidade_sagital = 180; // EIAS até crista posterior
espessura_parede = 6;       // Resistência mecânica para PETG
altura_apoio = 80;          // Altura de contenção da crista
raio_curvatura = 35;        // Suavização anatômica

$fn = 60; // Resolução da malha

module suporte_base() {
    difference() {
        // Bloco externo anatômico
        hull() {
            translate([-largura_biiliaca/2, 0, 0])
                cylinder(r=raio_curvatura + espessura_parede, h=altura_apoio, center=true);
            translate([largura_biiliaca/2, 0, 0])
                cylinder(r=raio_curvatura + espessura_parede, h=altura_apoio, center=true);
            translate([0, -profundidade_sagital, 0])
                cylinder(r=raio_curvatura + espessura_parede, h=altura_apoio, center=true);
        }
        
        // Alívio interno (espaço do corpo + offset de conforto)
        hull() {
            translate([-largura_biiliaca/2, 0, 0])
                cylinder(r=raio_curvatura, h=altura_apoio + 2, center=true);
            translate([largura_biiliaca/2, 0, 0])
                cylinder(r=raio_curvatura, h=altura_apoio + 2, center=true);
            translate([0, -profundidade_sagital, 0])
                cylinder(r=raio_curvatura, h=altura_apoio + 2, center=true);
        }
        
        // Abertura frontal para encaixe/desencaixe rápido
        translate([0, 50, 0])
            cube([largura_biiliaca * 0.8, 150, altura_apoio + 10], center=true);
            
        // Fendas para cintas de velcro (50 mm x 4 mm)
        translate([-largura_biiliaca/2, 10, 0])
            cube([6, 50, 52], center=true);
        translate([largura_biiliaca/2, 10, 0])
            cube([6, 50, 52], center=true);
    }
}

suporte_base();