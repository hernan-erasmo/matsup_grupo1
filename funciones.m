1; % Para que no ejecute el archivo en cuanto se cargue con 'source' desde gui.m

global func_actual;


function dlg_ingresar_zpg
  prompt = {"Polos (separados por comas)", "Ceros (separados por comas)", "Ganancia"};
  defaults = {"2,-3,-1+i,-1-i","2,-1","5"};
  rowscols = 1;
  dims = inputdlg(prompt, "Ingrese polos, ceros y ganancia de G(s)", rowscols, defaults);

  % El usuario apretó el botón de Cancelar
  if (length(dims) == 0)
    formato_tipo_lista("No se ha ingresado ninguna G(s)");
    return
  else
    formato_tipo_lista("");
  endif

  p = str2double(strsplit(dims{1},","));
  z = str2double(strsplit(dims{2},","));
  g = str2double(strsplit(dims{3},","));

  global func_actual;
  [num, den] = zp2tf(z,p,g);
  func_actual = tf(num,den);
endfunction


function dlg_ingresar_coef
  prompt = {"Numerador (separados por comas)", "Denominador (separados por comas)"};
  defaults = {"2,3", "1,0,4,3"};
  rowscols = 1;
  dims = inputdlg(prompt, "Ingrese coeficientes de G(s)", rowscols, defaults);

  % El usuario apretó el botón de Cancelar
  if (length(dims) == 0)
    formato_tipo_lista("No se ha ingresado ninguna G(s)");
    return
  else
    formato_tipo_lista("");
  endif

  num = str2double(strsplit(dims{1},","));
  den = str2double(strsplit(dims{2},","));

  if (any(arrayfun(@isnan, num)))
    errordlg("El numerador no tiene el formato correcto. Ingresarlo nuevamente.", "Error de carga");
    return
  elseif (any(arrayfun(@isnan, den)))
    errordlg("El denominador no tiene el formato correcto. Ingresarlo nuevamente.", "Error de carga");
    return
  else
    global func_actual;
    func_actual = tf(num,den);
  endif

endfunction


% Retorna una lista de 3 strings: el numerador, la barra de división y el denominador de G(s)
function [num, barra, den] = get_expresion_gs ()
  global func_actual;
  num = tfpoly2str(struct(func_actual).num{1}, "s");
  den = tfpoly2str(struct(func_actual).den{1}, "s");
  barra = repmat("-", 1, max(length(num), length(den)));
endfunction


function show_expresion_gs
  formato_tipo_lista("Expresion de G(s)");
  [num, barra, den] = get_expresion_gs;
  text(4,4,{num,barra,den}, "horizontalalignment", "center", "verticalalignment", "middle", "fontsize", 20);
endfunction


% Retorna un cell de strings, donde cada elemento representa un polo de G(s)
function str_polos = get_polos ()
  global func_actual;
  [ceros, polos, ganancia] = tf2zp(func_actual);
  polos_formateados = mat2str(polos);
  polos_formateados = strrep(polos_formateados, "[", "");
  polos_formateados = strrep(polos_formateados, "]", "");
  str_polos = strsplit(polos_formateados,";");
endfunction


function show_polos
  formato_tipo_lista("Polos de G(s)");
  str_polos = get_polos;
  text(4,4,str_polos,"horizontalalignment", "center", "verticalalignment", "middle", "fontsize", 20);
endfunction


% Retorna un cell de strings, donde cada elemento representa un cero de G(s)
function str_ceros = get_ceros ()
  global func_actual;
  [ceros, polos, ganancia] = tf2zp(func_actual);
  ceros_formateados = mat2str(ceros);
  ceros_formateados = strrep(ceros_formateados, "[", "");
  ceros_formateados = strrep(ceros_formateados, "]", "");
  str_ceros = strsplit(ceros_formateados,";");
endfunction


function show_ceros
  formato_tipo_lista("Ceros de G(s)");
  str_ceros = get_ceros;
  text(4,4,str_ceros,"horizontalalignment", "center", "verticalalignment", "middle", "fontsize", 20);
endfunction


% Retorna un escalar que representa la ganancia de G(s)
function ganancia = get_ganancia ()
  global func_actual
  [ceros, polos, ganancia] = tf2zp(func_actual);
endfunction


function show_ganancia
  formato_tipo_lista("Ganancia de G(s)");
  g = get_ganancia;
  str_ganancia = num2str(g);
  text(4,4,str_ganancia,"horizontalalignment", "center", "verticalalignment", "middle", "fontsize", 20);
endfunction


function show_estabilidad
  formato_tipo_lista("Ganancia de G(s)");
  estabilidad = get_estabilidad;
  str_estabilidad = "";

  if (estabilidad == -1)
    str_estabilidad = "G(s) no es estable"; % Hay polos con partes reales > 0
  elseif (estabilidad == 0)
    str_estabilidad = "G(s) es marginalmente estable"; % Los polos tienen partes reales < 0 salvo alguno = 0
  else
    str_estabilidad = "G(s) es absolutamente estable"; % Todos los polos tienen partes reales < 0
  endif

  text(4,4,str_estabilidad,"horizontalalignment", "center", "verticalalignment", "middle", "fontsize", 20);
endfunction


function esEstable = get_estabilidad ()
  global func_actual
  [ceros, polos, ganancia] = tf2zp(func_actual);

  % Si hay algun con parte real mayor a cero, ya no es estable
  if (any(arrayfun(@gt, real(polos), 0)))
    esEstable = -1;

  % Si algun polo tiene parte real cero, es marginalmente estable
  elseif (any(arrayfun(@eq, real(polos), 0)))
    esEstable = 0;

  % Caso contrario, es absolutamente estable
  else
    esEstable = 1;
  endif
endfunction


function graficar_polos_ceros
  global func_actual;
  figure(98,"position",[250,280,400,400]);
  pzmap(func_actual);
  title("Grafica de polos y ceros");
  legend("Polo","Cero");
  xlabel("Eje REAL");
  ylabel("Eje IMAGINARIO");
endfunction


function get_exp_zpg
  show_expresion_gs
  figure(5,"position",[50,50,400,400]);
  show_polos
  figure(8,"position",[500,50,400,400]);
  show_ceros
  figure(41,"position",[950,50,400,400]);
  show_ganancia
endfunction


function get_all
  get_exp_zpg
  graficar_polos_ceros
  figure(119,"position",[750,280,400,400]);
  show_estabilidad
endfunction


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     FUNCIONES DE FORMATO Y AUXILIARES        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function formato_tipo_lista (titulo_plot)
  % Propiedades del plot
  clf;
  axis([0 8 0 8]);
  box on;
  axis off;
  title(titulo_plot, "fontsize", 30);
endfunction
