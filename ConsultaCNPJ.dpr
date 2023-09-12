program ConsultaCNPJ;

uses
  Vcl.Forms,
  CNPJ in 'CNPJ.pas' {FormCNPJ},
  ConsultasCPFCNPJ in 'ConsultasCPFCNPJ.pas',
  Pkg.Json.DTO in 'Pkg.Json.DTO.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormCNPJ, FormCNPJ);
  Application.Run;
end.
