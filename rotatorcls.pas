unit rotatorcls;

interface
uses  SysUtils, activex, inifiles,variants;
Type
   TRotator = class

   Public
      maxstep: integer;
      step_size: single;
      position: integer;
      angle,target: single;
      reverse: boolean;
      comport: Tcomport;
      slot: array[1..8]of single;
      id: string[3];
      moving:boolean;
      constructor create(idc: string);
      procedure  send (str: string);
      procedure  move(angle_inc: single);
      procedure  move_absolute(angle: single);
      procedure sync(angle: single);
      procedure get_angle;
      procedure  halt();

   end;

implementation
constructor TRotator.create(IDC: string);
 var  inifile: TiniFile;
begin
   id := 'D' + idc;
    inifile := TINIFile.Create(FilePath + 'multifocus.ini');
     with inifile do
   begin
      maxstep := readinteger ('Rotator', 'MaxSteps', 10000);
   end;
   inifile.Free;
   step_size := 360.0/maxstep;
   slot[1]:=0.0;
   slot[2]:=45.0;
    slot[3]:=90.0;
   slot[4]:=135.0;
    slot[5]:=180.0;
   slot[6]:=225.0;
    slot[7]:=270.0;
   slot[8]:=315.0;

   moving:=false;

end;
procedure trotator.send(str: String);
var n: integer;
   cmd: string;
begin
   cmd := ID + str;
{   for n := 1 to length(cmd) do
   begin
      comport.TransmitChar(cmd[n]);
      sleep(5);
   end;}
    comport.WriteStr(cmd);
end;
procedure trotator.move(angle_inc: single);
var value: string;
angleV:single;
begin
   anglev:=angle + angle_inc;
   if anglev<0 then anglev:=360.0-anglev;
   while anglev >=360.0 do anglev:= anglev-360.0;
   value := 'N' + inttostr(round((anglev) / step_size)) + 'M#';
   target:=anglev;
   send(value);
end;
procedure  TRotator.move_absolute(angle: single);
var value: string;
begin
while angle >=360.0 do angle:= angle-360.0;
   value := 'N' + inttostr(trunc(angle / step_size)) + 'M#';
   target:=angle;
   send(value);
end;
procedure TRotator.halt;
begin
   send ('Q#');
   send('P#');
end;
procedure TRotator.sync(angle: single);
var value: string;
begin
   value := 'N' + inttostr(trunc(angle / step_size)) + 'S#';
   send(value);;
end;
procedure TRotator.get_angle;
begin
   send('P#');
end;

end.
