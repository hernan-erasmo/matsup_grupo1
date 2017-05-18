source("funciones.m");

% Deshabilita los botones de menu que vienen por defecto
f = figure("MenuBar", "None");

% La propiedad handlevisibility hace que no se limpie ese widget al llamar a clf
btn_ingresar = uimenu(f, "label", "Ingresar nueva G(s)", "handlevisibility", "off");
  btn_coeficientes = uimenu(btn_ingresar, "label", "Usando coeficientes", "callback", "dlg_ingresar_coef");
  btn_zpk = uimenu(btn_ingresar, "label", "Usando ceros, polos y ganancia");
btn_funciones = uimenu(f, "label", "Funciones", "handlevisibility", "off");
  btn_detalles_completos = uimenu(btn_funciones, "label", "Mostrar detalles completos");
  btn_caract_particular = uimenu(btn_funciones, "label", "Elegir caracteristica en particular");
    btn_expresion = uimenu(btn_caract_particular, "label", "Obtener expresion de G(s)", "callback", "get_expresion_gs");
    btn_polos = uimenu(btn_caract_particular, "label", "Indicar Polos");
    btn_ceros = uimenu(btn_caract_particular, "label", "Indicar Ceros");
    btn_ganancia = uimenu(btn_caract_particular, "label", "Indicar ganancia de G(s)");
    btn_pcg = uimenu(btn_caract_particular, "label", "Indicar polos, ceros y ganancia");
    btn_graf_pc = uimenu(btn_caract_particular, "label", "Graficar polos y ceros");
    btn_estabilidad = uimenu(btn_caract_particular, "label", "Indicar estabilidad");
btn_salir = uimenu(f, "Label", "Salir", "handlevisibility", "off", "callback", "close(gcf)");
