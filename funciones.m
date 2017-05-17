1; % Para que no ejecute el archivo en cuanto se cargue con 'source' desde gui.m

function dlg_ingresar_coef
  prompt = {"Numerador (separados por comas)", "Denominador (separados por comas)"};
  defaults = {"2,3", "1,0,4,3"};
  rowscols = 1;
  dims = inputdlg(prompt, "Ingrese coeficientes de G(s)", rowscols, defaults);
endfunction
