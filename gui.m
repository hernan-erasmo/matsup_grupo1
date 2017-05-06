% Crea la barra de menu

% Deshabilita los botones de menu que vienen por defecto
f = figure("MenuBar", "None");

btn_ingresar = uimenu(f, "Label", "Ingresar nueva G(s)");
btn_funciones = uimenu(f, "Label", "Funciones");
  btn_detalles_completos = uimenu(btn_funciones, "Label", "Mostrar detalles completos");
  btn_caract_particular = uimenu(btn_funciones, "Label", "Elegir caracteristica en particular");
    btn_expresion = uimenu(btn_caract_particular, "Label", "Obtener expresion de G(s)");
    btn_polos = uimenu(btn_caract_particular, "Label", "Indicar Polos");
    btn_ceros = uimenu(btn_caract_particular, "Label", "Indicar Ceros");
    btn_ganancia = uimenu(btn_caract_particular, "Label", "Indicar ganancia de G(s)");
    btn_pcg = uimenu(btn_caract_particular, "Label", "Indicar polos, ceros y ganancia");
    btn_graf_pc = uimenu(btn_caract_particular, "Label", "Graficar polos y ceros");
    btn_estabilidad = uimenu(btn_caract_particular, "Label", "Indicar estabilidad");
btn_salir = uimenu(f, "Label", "Salir", "Callback", "close(gcf)");
