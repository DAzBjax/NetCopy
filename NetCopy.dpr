program NetCopy;

uses
  Vcl.Forms,
  TestForm_Unit in 'TestForm_Unit.pas' {TestForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTestForm, TestForm);
  Application.Run;
end.
