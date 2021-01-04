unit TestForm_Unit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.IOUtils, System.Types;

type
  TTestForm = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TestForm: TTestForm;

implementation

{$R *.dfm}

    {
var
  //handle : Cardinal;
  unCompressedFile : TBytes;
  Stream : TFileStream;
begin
    unCompressedFile := nil;
    if (FileOpenDialog_ACTTS.Execute()) then  //����� ������� ������ ����� ��������� ���� � ������� ���
    begin
        //handle := DAXFRW.OpenForReadFile(FileOpenDialog_ACTTS.FileName);
        //SetLength(unCompressedFile, DAXFRW.GetSize(handle));
        //DAXFRW.LoadFromFile(handle, unCompressedFile, Length(unCompressedFile));
        //DAXFRW.CloseFile(handle);

        try
          Stream := TFileStream.Create(FileOpenDialog_ACTTS.FileName, fmOpenRead or fmShareDenyNone);
          SetLength(unCompressedFile, Stream.Size);
          Stream.ReadData(@unCompressedFile[0],Length(unCompressedFile));
        finally
          Stream.Free;
        end;

        if (unCompressedFile = nil) then
        begin
          raise Exception.Create('���������� ��������� ����, �������� �� ������ � ������ ����������.');
        end;

        ZCompress(unCompressedFile, compressedFile, TZCompressionLevel.zcDefault );
        Ed_ActTS.Text := ExtractFileName(FileOpenDialog_ACTTS.FileName);
    end;
    unCompressedFile := nil;
      }
procedure RemoveIfContans(var filesArrayOutput : TStringDynArray; lookingFor : string);
var
  i : integer;
begin
   for I := 0 to High(filesArrayOutput) do
   begin
       if (CompareText(filesArrayOutput[i],lookingFor) = 0)  then
       begin
           filesArrayOutput[i] := '';
       end;
   end;
end;

procedure TTestForm.Button1Click(Sender: TObject);
var
  filesArray, filesArrayOutput : TStringDynArray;
  I : integer;
  baseLen, outputDirectoryLen : integer;
  filename, fullBaseFilename, fullTargetFilename : string;
  baseFilesDir, targetFilesDir : string;
  lastWriteTimeSource, lastWriteTimeDest : TDateTime;
begin
   Memo1.Clear;
   baseLen := Length(Edit1.Text);

   baseFilesDir := Edit1.Text;
   targetFilesDir := Edit2.Text;

   filesArray := TDirectory.GetFiles(baseFilesDir, '*', TSearchOption.soAllDirectories);
   filesArrayOutput := TDirectory.GetFiles(targetFilesDir, '*', TSearchOption.soAllDirectories);


   //������ �������� �����
   outputDirectoryLen := Length(targetFilesDir);
   for I := 0 to High(filesArrayOutput) do
   begin
       filesArrayOutput[i] := filesArrayOutput[i].Remove(0, outputDirectoryLen);
   end;


   //�������� � ������� �� ������
   for I := 0 to High(filesArray) do
   begin
      //���
      fullBaseFilename := filesArray[i];

      //������� ���
      filename := filesArray[i].Remove(0,baseLen);
      //������� ��� �� ������ ������������
      RemoveIfContans(filesArrayOutput, filename);
      //������ ��� �� ������
      fullTargetFilename := targetFilesDir + filename;

      Memo1.Lines.Add( filename );

      if (TFile.Exists(fullTargetFilename)) then
      begin
         //���� ����� ��� ��� � �������� �����
         lastWriteTimeSource := Tfile.GetLastWriteTimeUtc(fullBaseFilename);
         lastWriteTimeDest := TFile.GetLastWriteTimeUtc(fullTargetFilename);

         //���� ����� ������ ��������� ������, ��� ���������� (���������� ����� ����� ������)
         if (lastWriteTimeSource < lastWriteTimeDest) then
         begin
             if (ForceDirectories(ExtractFilePath(fullTargetFilename))) then
             begin
                if (TFile.Exists(fullTargetFilename)) then
                begin
                     TFile.Delete(fullTargetFilename);
                end;
                TFile.Copy(fullBaseFilename, fullTargetFilename);
                      Memo1.Lines.Add( 'Overwrite' );
             end
             else
             begin
                      Memo1.Lines.Add( 'Error of forcing directories 1' );
             end;
         end
         else
         begin
               Memo1.Lines.Add( 'Not owerwrite' );
         end;
      end
      else
      begin
         if (ForceDirectories(ExtractFilePath(fullTargetFilename))) then
         begin
            TFile.Copy(fullBaseFilename, fullTargetFilename);
                      Memo1.Lines.Add( 'New file' );
             end
             else
             begin
                      Memo1.Lines.Add( 'Error of forcing directories 1' );
             end;
      end;
   end;


   Memo1.Lines.Add('------------------------- delete files:');
   //������� ������ ���� �� ������
   for I := 0 to High(filesArrayOutput) do
   begin
       if (filesArrayOutput[i] <> '') then
       begin
           //������ ��� �� ������
           fullTargetFilename := targetFilesDir + filesArrayOutput[i];

           if (TFile.Exists(fullTargetFilename)) then
           begin
               Memo1.Lines.Add(filesArrayOutput[i]);
               TFile.Delete(fullTargetFilename);
           end;
       end;
   end;


end;

end.
