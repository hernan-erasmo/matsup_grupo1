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

function get_expresion_gs
  clf;
  axis([0 8 0 8]);
  title(["Expresion de G(s)"]);
  global func_actual;
  num = tfpoly2str(struct(func_actual).num{1}, "s");
  den = tfpoly2str(struct(func_actual).den{1}, "s");
  barra = repmat("-", 1, max(length(num), length(den)));
  text(4,4,{num,barra,den}, "horizontalalignment", "center", "verticalalignment", "middle");
endfunction
