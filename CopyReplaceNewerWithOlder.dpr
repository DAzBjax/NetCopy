program CopyReplaceNewerWithOlder;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils, System.IOUtils, System.Types;

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

var
  filesArray, filesArrayOutput : TStringDynArray;
  I : integer;
  baseLen, outputDirectoryLen : integer;
  filename, fullBaseFilename, fullTargetFilename : string;
  baseFilesDir, targetFilesDir : string;
  lastWriteTimeSource, lastWriteTimeDest : TDateTime;

  doOut : boolean;
  mode : boolean;
begin
  try

   //Memo1.Clear;
   baseFilesDir := ParamStr(1);//Edit1.Text;

   baseLen := Length(baseFilesDir);

   targetFilesDir := ParamStr(2);//Edit2.Text;


   if ((Length(baseFilesDir)=0) or (Length(targetFilesDir)=0)) then exit;

   doOut := CompareText(ParamStr(4),'-notextout') <> 0;

   mode := false;
   mode := CompareText(ParamStr(5), '-AllDiffs') = 0;


   filesArray := TDirectory.GetFiles(baseFilesDir, '*', TSearchOption.soAllDirectories);
   if (not TDirectory.Exists(targetFilesDir)) then
   begin
      ForceDirectories(targetFilesDir);
   end;
   filesArrayOutput := TDirectory.GetFiles(targetFilesDir, '*', TSearchOption.soAllDirectories);


   //чистим выходные имена
   outputDirectoryLen := Length(targetFilesDir);
   for I := 0 to High(filesArrayOutput) do
   begin
       filesArrayOutput[i] := filesArrayOutput[i].Remove(0, outputDirectoryLen);
   end;


   //копируем и удаляем из списка
   for I := 0 to High(filesArray) do
   begin
      //хэш
      fullBaseFilename := filesArray[i];

      //базовое имя
      filename := filesArray[i].Remove(0,baseLen);
      //удаляем имя из списка обработанных
      RemoveIfContans(filesArrayOutput, filename);
      //полное имя на выходе
      fullTargetFilename := targetFilesDir + filename;

      if doOut then Writeln(filename);
      //Memo1.Lines.Add( filename );

      if (TFile.Exists(fullTargetFilename)) then
      begin
         //есть такой фал уже в конечной папке
         lastWriteTimeSource := Tfile.GetLastWriteTimeUtc(fullBaseFilename);
         lastWriteTimeDest := TFile.GetLastWriteTimeUtc(fullTargetFilename);

         //если время записи источника меньше, чем назначения (перезапись более новых файлов)
         if ((lastWriteTimeSource < lastWriteTimeDest) or (mode and (lastWriteTimeSource <> lastWriteTimeDest))) then
         begin
             if (ForceDirectories(ExtractFilePath(fullTargetFilename))) then
             begin
                if (TFile.Exists(fullTargetFilename)) then
                begin
                     TFile.Delete(fullTargetFilename);
                end;
                    TFile.Copy(fullBaseFilename, fullTargetFilename);
                    if doOut then Writeln('Overwrite');
                      //Memo1.Lines.Add( 'Overwrite' );
             end
             else
             begin
                if doOut then Writeln('Error of forcing directories 1');
                //Memo1.Lines.Add( 'Error of forcing directories 1' );
             end;
         end
         else
         begin
            if doOut then Writeln( 'Not owerwrite');
            //Memo1.Lines.Add( 'Not owerwrite' );
         end;
      end
      else
      begin
         if (ForceDirectories(ExtractFilePath(fullTargetFilename))) then
         begin
            TFile.Copy(fullBaseFilename, fullTargetFilename);
                if doOut then Writeln('New file');
                //Memo1.Lines.Add( 'New file' );
             end
             else
             begin
                if doOut then Writeln('Error of forcing directories 2');
                //Memo1.Lines.Add( 'Error of forcing directories 1' );
             end;
      end;
   end;


   if doOut then Writeln('------------------------- delete files:');
   //Memo1.Lines.Add('------------------------- delete files:');
   //удаляем лишние фалы на выходе
   for I := 0 to High(filesArrayOutput) do
   begin
       if (filesArrayOutput[i] <> '') then
       begin
           //полное имя на выходе
           fullTargetFilename := targetFilesDir + filesArrayOutput[i];

           if (TFile.Exists(fullTargetFilename)) then
           begin
               if doOut then Writeln(filesArrayOutput[i]);
               //Memo1.Lines.Add(filesArrayOutput[i]);
               TFile.Delete(fullTargetFilename);
           end;
       end;
   end;


   if (CompareText(ParamStr(3),'-wait') = 0) then
   begin
      Writeln('done');
      readln;
   end;

  except
    on E: Exception do

  end;
end.
