unit LXUtils;

interface

uses SysUtils, classes, types;

function Inttodec(de: Integer; prec: Byte): String;
function IntToAr(ar: Integer; prec: Byte): String;
function LX200Dectoint(dec: String; prec: boolean): Integer;
function LX200Artoint(ar: String; prec: boolean): Integer;
function Artoint(ar: String): Integer;
function longitudetohr(ar: String): Extended;
function longitudetodeg(ar: String): Double;
function latitudetodeg(ar: String): Double;
function DoubletoLXdec(de: Double; prec: Byte): string;
function DoubleToLXAr(ra: Double; prec: Byte): string;
function LX200AZtoint(az: String; prec: boolean): Integer;

implementation

function Inttodec(de: Integer; prec: Byte): String;

var
  g, m, s, tmp, sg: Integer;
  sig: char;
  str: string;
begin

  sig := '+';
  sg := 1;
  if (de = 0) then
    sg := 0;
  if (de < 0) then
  begin
    sg := -1;
    de := abs(de);
    sig := '-';
  end;
  g := de DIV 3600;
  tmp := de MOD 3600;
  m := tmp DIV 60;
  s := tmp MOD 60;
  case prec of
    0:
      str := Format('%s%0.2d°%0.2d''%0.2d"', [sig, g, m, s]);
    1:
      str := Format('%s%0.2dß%0.2d''%0.2d#', [sig, g, m, s]);
    2:
      str := Format('%s%0.2dß%0.2d#', [sig, g, m]);
    3:
      str := Format('%0.3dß%0.2d''%0.2d#', [g, m, s]);
    4:
      str := Format('%0.3dß%0.2d#', [g, m]); // ß

  end;

  Inttodec := str;

end;

// ------------------------------------------------------------------------
function IntToAr(ar: Integer; prec: Byte): String;

var
  h, m, s, tmp, de: Integer;
  arstr: string;
begin

  if prec = 0 then
  begin
    de := abs(ar MOD 150);
    ar := ar DIV 10;
  end;
  ar := ar DIV 15;
  ar := ar MOD (24 * 3600);
  if (ar < 0) then
    ar := (24 * 3600) + ar;

  h := (ar DIV 3600);
  tmp := ar MOD 3600;
  m := tmp DIV 60;
  s := tmp MOD 60;
  case prec of
    0:
      arstr := Format('%0.2dh%0.2dm%0.2ds.%0.3ds', [h, m, s, de]);
    1:
      arstr := Format('%0.2d:%0.2d:%0.2d#', [h, m, s]);
    2:
      begin
        s := s DIV 6;
        arstr := Format('%0.2d:%0.2d.%0.1d#', [h, m, s])
      end;
    3:
      arstr := Format('%0.2dh%0.2dm%0.2ds', [h, m, s]);
  end;
  IntToAr := arstr;

end;

function LX200Dectoint(dec: String; prec: boolean): Integer;

var
  temp, Signo: Integer;
begin
  if (dec[1] = '-') then
    Signo := -1
  else
    Signo := 1;

  temp := ((ord(dec[2]) - 48) * 10 + (ord(dec[3]) - 48)) * 3600 +
    ((ord(dec[5]) - 48) * 10 + (ord(dec[6]) - 48)) * 60;
  if prec then

    temp := (temp + ((ord(dec[8]) - 48) * 10 + (ord(dec[9]) - 48))) * Signo;
  LX200Dectoint := temp;
end;

function LX200AZtoint(az: String; prec: boolean): Integer;

var
  temp: Integer;
begin

  temp := (((ord(az[1]) - 48) * 100) + (ord(az[2]) - 48) * 10 +
    (ord(az[3]) - 48)) * 3600 +
    ((ord(az[5]) - 48) * 10 + (ord(az[6]) - 48)) * 60;
  if prec then

    temp := (temp + ((ord(az[8]) - 48) * 10 + (ord(az[9]) - 48)));
  LX200AZtoint := temp;
end;

function LX200Artoint(ar: String; prec: boolean): Integer;

var
  temp: Integer;
begin

  if prec then
  // temp := (strtoint(Copy(ar, 1, 2)) * 3600 + strtoint(Copy(ar, 4, 2)) * 60 +
  // strtoint(Copy(ar, 7, 2))) * 15
  begin
    temp := (((ord(ar[1]) - 48) * 10 + (ord(ar[2]) - 48)) * 3600 +
      ((ord(ar[4]) - 48) * 10 + (ord(ar[5]) - 48)) * 60 +
      ((ord(ar[7]) - 48) * 10 + (ord(ar[8]) - 48))) * 15 + ord(ar[10]) - 48
  end
  else
    temp := (strtoint(Copy(ar, 4, 2)) * 3600 + strtoint(Copy(ar, 7,
      2) + Copy(ar, 10, 1)) * 6) * 15;
  LX200Artoint := temp;
end;

function Artoint(ar: String): Integer;

var
  temp: Integer;
begin

  temp := 15 * (strtoint(Copy(ar, 1, 2)) * 3600 + strtoint(Copy(ar, 4, 2)) * 60
    + strtoint(Copy(ar, 7, 2))) + strtoint(Copy(ar, 11, 2));
  Artoint := temp;
end;

function longitudetohr(ar: String): Extended;

var
  temp: Integer;
begin

  temp := (strtoint(Copy(ar, 2, 3)) * 3600 + strtoint(Copy(ar, 6, 2)) * 60 +
    strtoint(Copy(ar, 9, 2)));
  longitudetohr := (temp / (3600.00 * 15.0));
end;

function longitudetodeg(ar: String): Double;

var
  temp: Integer;
begin

  temp := (strtoint(Copy(ar, 2, 3)) * 3600 + strtoint(Copy(ar, 6, 2)) * 60);
  // +    strtoint(Copy(ar, 9, 2)));
  if ar[1] = '-' then
    temp := -temp;
  longitudetodeg := (temp / (3600.00));
end;

function latitudetodeg(ar: String): Double;

var
  temp: Integer;
begin

  temp := (strtoint(Copy(ar, 2, 2)) * 3600 + strtoint(Copy(ar, 5, 2)) * 60);
  // +strtoint(Copy(ar, 8, 2)));
  if ar[1] = '-' then
    temp := -temp;
  latitudetodeg := (temp / (3600.00));
end;

// Function
// #:Sr 11:46.3#:Sd +50ß33#
// #:Sr 12:24:11#:Sd +51ß32:41#
function DoubletoLXdec(de: Double; prec: Byte): string;

var
  g, m, s: Integer;
  tmp: Double;
  sig: char;
  destr: string;
begin

  sig := '+';

  if (de < 0.0) then
  begin
    de := -de;
    sig := '-';
  end;
  g := trunc(de);
  tmp := (de - g);
  m := trunc(tmp * 60);
  tmp := (tmp * 60.0 - m);
  s := trunc(tmp * 60);
  case prec of
    0:
      destr := Format('%s%0.2d°%0.2d''%0.2d"', [sig, g, m, s]);
    1:
      destr := Format('%s%0.2d:%0.2d''%0.2d#', [sig, g, m, s]);
    2:
      destr := Format('%s%0.2dß%0.2d#', [sig, g, m]);
    3:
      destr := Format('%0.3dß%0.2d''%0.2d#', [g, m, s]);
    4:
      destr := Format('%0.3dß%0.2d#', [g, m]); // ß
  end;

  DoubletoLXdec := destr;

End;

function DoubleToLXAr(ra: Double; prec: Byte): string;

var
  h, m, s, de: Integer;
  tmp: Double;
  arstr: string;

begin
  //arstr := StrAlloc(20);

  h := trunc(ra);
  tmp := frac(ra);
  m := trunc(tmp * 60.0);
  tmp := frac(tmp * 60.0);
  s := trunc(tmp * 60);
  tmp := frac(tmp * 10);
  de := trunc(tmp * 10);

  case prec of

    0:
      arstr := Format('%0.2dh%0.2dm%0.2d.%0.1ds', [h, m, s, de]);
    1:
      arstr := Format('%0.2d:%0.2d:%0.2d#', [h, m, s]);
    2:
      begin
        s := s div 6;
        arstr := Format('%0.2d:%0.2d.%0.1d#', [h, m, s])
      end;
    3:
      arstr := Format('%0.2dh%0.2dm%0.2ds', [h, m, s]);
  end;
  DoubleToLXAr := arstr;

end;

end.
