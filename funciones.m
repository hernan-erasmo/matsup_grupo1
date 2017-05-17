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
