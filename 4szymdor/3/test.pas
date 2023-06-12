program TestParser;

var
  x, y, z: integer;
  i: integer;

begin
  x := 10;
  y := 20;

  if x > y then
  begin
    z := x - y;
    writeln('Condition x > y is true.');
  end
  else
  begin
    z := y - x;
    writeln('Condition x > y is false.');
  end;
  
  writeln('The value of z is: ', z);
  
  i := 1;
  while i <= 5 do
  begin
    writeln('Current value of i: ', i);
    i := i + 1;
  end;
  
  i := 10;
  repeat
    writeln('Current value of i: ', i);
    i := i - 2;
  until i <= 0;
end.

