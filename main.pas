program TicTacToe;

uses crt;

const
  EMPTY = '-';
  X = 'X';
  O = 'O';

type
  TBoard = array[1..3, 1..3] of Char;

var
  Board: TBoard;
  CurrentPlayer: Char;

procedure InitializeBoard;
var
  i, j: Integer;
begin
  for i := 1 to 3 do
    for j := 1 to 3 do
      Board[i, j] := EMPTY;
end;

procedure DrawBoard;
var
  i, j: Integer;
begin
  clrscr;
  writeln('Tic Tac Toe');
  writeln('-----------');
  for i := 1 to 3 do
  begin
    for j := 1 to 3 do
      write('| ', Board[i, j], ' ');
    writeln('|');
    writeln('-----------');
  end;
end;

function CheckDraw: Boolean;
var
  i, j: Integer;
begin
  for i := 1 to 3 do
    for j := 1 to 3 do
      if Board[i, j] = EMPTY then
        Exit(False); // there is at least one empty cell, so the game is not a draw

  // all cells are filled and no winner was found, so the game is a draw
  Exit(True);
end;


function CheckWin: Boolean;
var
  i: Integer;
begin
  // Check rows
  for i := 1 to 3 do
    if (Board[i, 1] <> EMPTY) and (Board[i, 1] = Board[i, 2]) and (Board[i, 2] = Board[i, 3]) then
      Exit(True);

  // Check columns
  for i := 1 to 3 do
    if (Board[1, i] <> EMPTY) and (Board[1, i] = Board[2, i]) and (Board[2, i] = Board[3, i]) then
      Exit(True);

  // Check diagonals
  if (Board[1, 1] <> EMPTY) and (Board[1, 1] = Board[2, 2]) and (Board[2, 2] = Board[3, 3]) then
    Exit(True);
  if (Board[1, 3] <> EMPTY) and (Board[1, 3] = Board[2, 2]) and (Board[2, 2] = Board[3, 1]) then
    Exit(True);

  Exit(False);
end;


procedure Play;
var
  x, y: Integer;
begin
  repeat
    writeln(CurrentPlayer, ', enter the row and column (e.g. 1 2):');
    readln(x, y);
  until (x >= 1) and (x <= 3) and (y >= 1) and (y <= 3) and (Board[x, y] = EMPTY);

  Board[x, y] := CurrentPlayer;
end;

procedure SwitchPlayer;
begin
  if CurrentPlayer = X then
    CurrentPlayer := O
  else
    CurrentPlayer := X;
end;

var
  Player1Wins, Player2Wins: Integer;

procedure MainLoop;
var
  Replay: Char;
begin
  Player1Wins := 0;
  Player2Wins := 0;
  repeat
    InitializeBoard;
    CurrentPlayer := X;
    repeat
      DrawBoard;
      Play;
      if CheckWin then
        Break
      else if CheckDraw then
        begin
          DrawBoard;
          writeln('The game is a draw.');
          readln;
          Exit;
        end;
      SwitchPlayer;
    until False;
    DrawBoard;
    writeln(CurrentPlayer, ' wins!');
    if CurrentPlayer = X then
      Inc(Player1Wins)
    else
      Inc(Player2Wins);
    writeln('Player 1: ', Player1Wins);
    writeln('Player 2: ', Player2Wins);
    writeln('Do you want to play again? (Y/N)');
    readln(Replay);
  until not (Replay in ['Y', 'y']);
end;




begin
  MainLoop;
end.
