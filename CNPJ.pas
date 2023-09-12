unit CNPJ;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, REST.Types, Vcl.StdCtrls, Vcl.ExtCtrls,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, IdHTTP, System.JSON, System.Generics.Collections, REST.Json;

type
  TFormCNPJ = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Edit1: TEdit;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    Label1: TLabel;
    Label2: TLabel;
    infos: TLabel;
    procedure Button1Click(Sender: TObject);

type
  TNaturezaJuridica = class
  public
    id: string;
    descricao: string;
  end;

  TQualificacao = class
  public
    id: Integer;
    descricao: string;
  end;

  TPais = class
  public
    id: string;
    iso2: string;
    iso3: string;
    nome: string;
    comex_id: string;
  end;

  TSocio = class
  public
    cpf_cnpj_socio: string;
    nome: string;
    tipo: string;
    data_entrada: string;
    cpf_representante_legal: string;
    nome_representante: string;
    faixa_etaria: string;
    atualizado_em: string;
    pais_id: string;
    qualificacao_socio: TQualificacao;
    qualificacao_representante: TQualificacao;
    pais: TPais;
  end;

  TAtividadeSecundaria = class
  public
    id: string;
    secao: string;
    divisao: string;
    grupo: string;
    classe: string;
    subclasse: string;
    descricao: string;
  end;

  TAtividadePrincipal = class
  public
    id: string;
    secao: string;
    divisao: string;
    grupo: string;
    classe: string;
    subclasse: string;
    descricao: string;
  end;

  TInscricaoEstadual = class
  public
    inscricao_estadual: string;
    ativo: Boolean;
    atualizado_em: string;
    estado: TObject;
  end;

  TEstabelecimento = class
  public
    cnpj: string;
    atividades_secundarias: TObjectList<TAtividadeSecundaria>;
    cnpj_raiz: string;
    cnpj_ordem: string;
    cnpj_digito_verificador: string;
    tipo: string;
    nome_fantasia: string;
    situacao_cadastral: string;
    data_situacao_cadastral: string;
    data_inicio_atividade: string;
    nome_cidade_exterior: string;
    tipo_logradouro: string;
    logradouro: string;
    numero: string;
    complemento: string;
    bairro: string;
    cep: string;
    ddd1: string;
    telefone1: string;
    ddd2: string;
    telefone2: string;
    ddd_fax: string;
    fax: string;
    email: string;
    situacao_especial: string;
    data_situacao_especial: string;
    atualizado_em: string;
    atividade_principal: TAtividadePrincipal;
    pais: TPais;
    estado: TObject;
    cidade: TObject;
    motivo_situacao_cadastral: string;
    inscricoes_estaduais: TObjectList<TInscricaoEstadual>;
  end;

  TSimles = class
  public
    simples: string;
    data_opcao_simples: string;
    data_exclusao_simples: string;
    mei: string;
    data_opcao_mei: string;
    data_exclusao_mei: string;
    atualizado_em: string;
  end;

  TPorte = class
  public
    id: string;
    descricao: string;
  end;

  TCNPJData = class
  public
    cnpj_raiz: string;
    razao_social: string;
    capital_social: string;
    responsavel_federativo: string;
    atualizado_em: string;
    porte: TPorte;
    natureza_juridica: TNaturezaJuridica;
    qualificacao_do_responsavel: TQualificacao;
    socios: TObjectList<TSocio>;
    simples: TSimles;
    estabelecimento: TEstabelecimento;
  end;

  private
    { Private declarations }
    function ConsultarCNPJ(cnpj: string): TCNPJData;
  public

    { Public declarations }
  end;

var
  FormCNPJ: TFormCNPJ;

implementation

uses ConsultasCPFCNPJ, Pkg.Json.DTO;


function TFormCNPJ.ConsultarCNPJ(cnpj: string): TCNPJData;
var
  IdHTTP: TIdHTTP;
  JsonResponse: string;
  CNPJData: TRoot;
begin
  IdHTTP := TIdHTTP.Create(nil);
  try
    JsonResponse := IdHTTP.Get('https://publica.cnpj.ws/cnpj/' + cnpj);
    CNPJData := TJson.JsonToObject<TRoot>(JsonResponse);
    //Result := CNPJData;
  finally
    IdHTTP.Free;
  end;
end;
{$R *.dfm}

procedure TFormCNPJ.Button1Click(Sender: TObject);
var
  DADOSCNPJ: TRoot;
begin
// Configurar o RESTRequest para fazer a solicitação GET à API

//  RESTClient1.BaseURL := 'https://publica.cnpj.ws';

//  RESTRequest1.Method := rmGET;
  RESTRequest1.Resource := 'cnpj/'+Edit1.Text; // Substitua pelo CNPJ desejado

  try
    // Executar a solicitação
    RESTRequest1.Execute;

    // Verificar se a solicitação foi bem-sucedida
    if RESTResponse1.StatusCode = 200 then
    begin
      // Converter a resposta JSON em um objeto Delphi
      DADOSCNPJ := TJson.JsonToObject<TRoot>(RESTResponse1.Content);

      // Agora você pode acessar os dados da consulta, por exemplo:
      infos.Caption := 'Razão: '+DADOSCNPJ.RazaoSocial + sLineBreak + sLineBreak +'Fantasia: '+ DADOSCNPJ.Estabelecimento.NomeFantasia
      + sLineBreak +sLineBreak +
      'Cep: '+DADOSCNPJ.Estabelecimento.Cep+ sLineBreak +sLineBreak + 'Cidade: '+UpperCase(DADOSCNPJ.Estabelecimento.Cidade.Nome) ;

    end
    else
    begin
      ShowMessage('Erro na solicitação: ' + RESTResponse1.StatusText);
    end;
  except
    on E: Exception do
    begin
      ShowMessage('Erro: ' + E.Message);
    end;
  end;
end;

end.
