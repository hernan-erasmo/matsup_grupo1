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


function get_polos
  % Propiedades del plot
  clf;
  axis([0 8 0 8]);
  box on;
  axis off;
  title("Polos de G(s)", "fontsize", 30);

  global func_actual;
  [ceros, polos, ganancia] = tf2zp(func_actual);
  str_polos = mat2str(polos);
  str_polos = strrep(str_polos, "[", "");
  str_polos = strrep(str_polos, "]", "");
  polos_formateados = strsplit(str_polos,";");
  text(4,4,polos_formateados,"horizontalalignment", "center", "verticalalignment", "middle", "fontsize", 20);
endfunction
