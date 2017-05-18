1; % Para que no ejecute el archivo en cuanto se cargue con 'source' desde gui.m

global func_actual;

function dlg_ingresar_coef
  prompt = {"Numerador (separados por comas)", "Denominador (separados por comas)"};
  defaults = {"2,3", "1,0,4,3"};
  rowscols = 1;
  dims = inputdlg(prompt, "Ingrese coeficientes de G(s)", rowscols, defaults);

  num = str2double(strsplit(dims{1},","));
  den = str2double(strsplit(dims{2},","));

  global func_actual;
  func_actual = tf(num,den);
endfunction


function [num, barra, den] = get_expresion_gs ()
  global func_actual;
  num = tfpoly2str(struct(func_actual).num{1}, "s");
  den = tfpoly2str(struct(func_actual).den{1}, "s");
  barra = repmat("-", 1, max(length(num), length(den)));
endfunction


function show_expresion_gs (num, barra, den)
  % Propiedades del plot
  clf;
  axis([0 8 0 8]);
  box on;
  axis off;
  title("Expresion de G(s)","fontsize",30);

  [num, barra, den] = get_expresion_gs;

  text(4,4,{num,barra,den}, "horizontalalignment", "center", "verticalalignment", "middle", "fontsize", 20);
endfunction


function str_polos = get_polos ()
  global func_actual;
  [ceros, polos, ganancia] = tf2zp(func_actual);
  polos_formateados = mat2str(polos);
  polos_formateados = strrep(polos_formateados, "[", "");
  polos_formateados = strrep(polos_formateados, "]", "");
  str_polos = strsplit(polos_formateados,";");
endfunction


function show_polos
  % Propiedades del plot
  clf;
  axis([0 8 0 8]);
  box on;
  axis off;
  title("Polos de G(s)", "fontsize", 30);

  str_polos = get_polos;
  text(4,4,str_polos,"horizontalalignment", "center", "verticalalignment", "middle", "fontsize", 20);
endfunction
