pkg load control;
pkg load signal;

source("funciones.m");

% Deshabilita los botones de menu que vienen por defecto
f = figure("MenuBar", "None");

% La propiedad handlevisibility hace que no se limpie ese widget al llamar a clf
btn_ingresar = uimenu(f, "label", "Ingresar nueva G(s)", "handlevisibility", "off");
  btn_coeficientes = uimenu(btn_ingresar, "label", "Usando coeficientes", "callback", "dlg_ingresar_coef");
  btn_zpk = uimenu(btn_ingresar, "label", "Usando ceros, polos y ganancia", "callback", "dlg_ingresar_zpg");
btn_funciones = uimenu(f, "label", "Funciones", "handlevisibility", "off");
  btn_detalles_completos = uimenu(btn_funciones, "label", "Mostrar detalles completos", "callback", "get_all");
  btn_caract_particular = uimenu(btn_funciones, "label", "Elegir caracteristica en particular");
    btn_expresion = uimenu(btn_caract_particular, "label", "Obtener expresion de G(s)", "callback", "show_expresion_gs");
    btn_polos = uimenu(btn_caract_particular, "label", "Indicar Polos", "callback", "show_polos");
    btn_ceros = uimenu(btn_caract_particular, "label", "Indicar Ceros", "callback", "show_ceros");
    btn_ganancia = uimenu(btn_caract_particular, "label", "Indicar ganancia de G(s)", "callback", "show_ganancia");
    btn_pcg = uimenu(btn_caract_particular, "label", "Indicar polos, ceros y ganancia", "callback", "get_exp_zpg");
    btn_graf_pc = uimenu(btn_caract_particular, "label", "Graficar polos y ceros", "callback", "graficar_polos_ceros");
    btn_estabilidad = uimenu(btn_caract_particular, "label", "Indicar estabilidad", "callback", "show_estabilidad");
btn_salir = uimenu(f, "Label", "Salir", "handlevisibility", "off", "callback", "close(gcf)");

box on;
axis off;
text(0.15,0.8,"Bienvenido a ", "fontsize", 30);
text(0.625,0.8,"ASIC", "fontsize", 30,"color","blue","fontweight","bold");
text(0.14,0.4,"Para comenzar ingrese una nueva G(s)", "fontsize", 15);