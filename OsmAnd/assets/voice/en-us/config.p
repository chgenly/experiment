:- op('==', xfy, 500).
version(0).
:- write("!!!: this is a test"),nl .
:- bound(div), write("!!!: div is bound"), nl.
:- X is div(5, 2), write("!!!: div(5,2)="), write(X), nl.

% before each announcement (beep)
preamble - [].


%% TURNS 
turn('left', ['turn.ogg', 'left-e.ogg']).
turn('left_sh', ['turn.ogg', 'sharp_left-e.ogg']).
turn('left_sl', ['turn.ogg', 'left-e.ogg']).
turn('right', ['turn.ogg', 'right-e.ogg']).
turn('right_sh', ['turn.ogg', 'sharp_right-e.ogg']).
turn('right_sl', ['turn.ogg', 'right-e.ogg']).
turn('right_keep', ['keep_right-e.ogg']).
turn('left_keep', ['keep_left-e.ogg']).

prepare_turn(Turn, Dist) == ['Prepare_to-a.ogg', M, 'after-m.ogg', D] :- 
			distance(Dist) == D, turn(Turn, M).
turn(Turn, Dist) == ['after-m.ogg', delay_250, D, delay_250, M] :- 
			distance(Dist) == D, turn(Turn, M).
turn(Turn) == M :- turn(Turn, M).

prepare_make_ut(Dist) == ['Prepare_to-a.ogg',delay_300,'turn_back-e.ogg', 'after-m.ogg', delay_300, D ] :- 
		distance(Dist) == D.

prepare_roundabout(Dist) == ['prepare_to-enter.ogg', 'after-m.ogg', delay_300, D] :- 
		distance(Dist) == D.

make_ut(Dist) == ['after-m.ogg', delay_300, D, delay_300, 'turn_back-e.ogg'] :- 
			distance(Dist) == D.
make_ut == ['turn_back-e.ogg'].

roundabout(Dist, _Angle, Exit) == ['after-m.ogg', delay_300, D, delay_300, 'enter_the_roundabout-e.ogg', delay_250, 'and_take.ogg', delay_250, E, 'exit-e.ogg'] :- distance(Dist) == D, nth(Exit, E).
roundabout(_Angle, Exit) == ['taking.ogg', delay_250,  E, 'exit-e.ogg'] :- nth(Exit, E).

and_arrive_destination == ['arrive_at_your_destination-e.ogg']. % Miss and?
then == ['then.ogg', delay_350].
reached_destination == ['you_have_reached_your_destination.ogg'].
bear_right == ['keep_right-e.ogg'].
bear_left == ['keep_left-e.ogg'].
route_recalc(_Dist) == ['recalc.ogg'].  %nothing to say possibly beep?	
route_new_calc(Dist) == ['the_trip_is.ogg', delay_150, D] :- distance(Dist) == D. 

location_lost == ['gps_signal_lost.ogg'].

go_ahead(Dist) == ['drive_for-h.ogg', delay_250,  D]:- distance(Dist) == D.
go_ahead == ['continue_straight-e.ogg'].

%% 
nth(1, '1st.ogg').
nth(2, '2nd.ogg').
nth(3, '3rd.ogg').
nth(4, '4th.ogg').
nth(5, '5th.ogg').
nth(6, '6th.ogg').
nth(7, '7th.ogg').
nth(8, '8th.ogg').
nth(9, '9th.ogg').
nth(10, '10th.ogg').
nth(11, '11th.ogg').
nth(12, '12th.ogg').
nth(13, '13th.ogg').
nth(14, '14th.ogg').
nth(15, '15th.ogg').
nth(16, '16th.ogg').
nth(17, '17th.ogg').

num(N) == ['0,ogg'] :- N is 0.
num(N) == ['1.ogg'] :- N is 1.
num(N) == ['2.ogg'] :- N is 2.
num(N) == ['3.ogg'] :- N is 3.
num(N) == ['4.ogg'] :- N is 4.
num(N) == ['5.ogg'] :- N is 5.
num(N) == ['6.ogg'] :- N is 6.
num(N) == ['7.ogg'] :- N is 7.
num(N) == ['8.ogg'] :- N is 8.
num(N) == ['9.ogg'] :- N is 9.
num(N) == ['10.ogg'] :- N is 10.
num(N) == ['11.ogg'] :- N is 11.
num(N) == ['12.ogg'] :- N is 12.
num(N) == ['13.ogg'] :- N is 13.
num(N) == ['14.ogg'] :- N is 14.
num(N) == ['15.ogg'] :- N is 15.
num(N) == ['16.ogg'] :- N is 16.
num(N) == ['17.ogg'] :- N is 17.
num(N) == ['18.ogg'] :- N is 18.
num(N) == ['19.ogg'] :- N is 19.
num(N) == ['20.ogg'] :- N is 20.
num(N) == ['30.ogg'] :- N is 30.
num(N) == ['40.ogg'] :- N is 40.
num(N) == ['50.ogg'] :- N is 50.
num(N) == ['60.ogg'] :- N is 60.
num(N) == ['70.ogg'] :- N is 70.
num(N) == ['80.ogg'] :- N is 80.
num(N) == ['90.ogg'] :- N is 90.
num(N) == [T, O] :- N < 100, Tens is floor(N/10)*10, Ones is N-Tens,  num(Tens) == T, num(Ones) == O, !.
num(N) == [H, 'hundred.ogg', R] :- N < 1000, HundredsDigit is floor(N/100), Rest is N-HundredsDigit*100, num(HundredsDigit) == H, (Rest is 0, unify(R, []); num(Rest) == R), !.
num(N) == [T, 'thousand.ogg', R ] :- N < 10000, ThousdandsDigit is floor(N/1000), Rest is N-ThousdandsDigit*1000, num(ThousdandsDigit) == T, (Rest is 0, unify(R, []); num(Rest) == R), !.
num(N) == ['a_lot_of.ogg'] :- !.

distance(Dist) == D :- measure('km-m'), distance_km(Dist) == D.
distance(Dist) == D :- distance_mi(Dist) == D.

%%% distance measure
distance_km(Dist) == [ X, 'meters.ogg'] :- Dist < 100, D is round(Dist/10.0)*10, num(D) == X, !.
distance_km(Dist) == [ X, ' meters,ogg'] :- Dist < 1000, D is round(2*Dist/100.0)*50, num(D) == X, !.
distance_km(Dist) == ['about.ogg', '1.ogg', 'kilometer.ogg'] :- Dist < 1500, !.
distance_km(Dist) == ['about.ogg', X, 'kilometers.ogg'] :- Dist < 10000, D is round(Dist/1000.0), num(D) == X, !.
distance_km(Dist) == [ X, 'kilometers.ogg'] :- D is round(Dist/1000.0), num(D) == X, !.

%%% distance measure
%distance_mi(Dist) == [X1, X2, X3, X4, X5, X6, X7, X8] :-  
%   B = 161,
%  (num_atom(Dist, X1); X1="fail num_atom"), 
%  (T2 is Dist*10, num_atom(T2, X2); X2="mul failed"),
%  (T3 is Dist*10+B*10/2, num_atom(T3, X3); X3 ="left failed"),
%  (T4 is div(Dist*10+B*10/2, B*10), num_atom(T4, X4); A="div failed"),
%  (bound(div), X5="div bound"; X5="div not bound"),
%  (bound(round), X6="round bound"; X6="round not bound"),
%  (bound(floor), X7="floor bound"; X7="floor not bound"),
%  (T8 is round(105.6), num_atom(T8, X8); X8="round failed")
%.

distance_mi(Dist) == [ X, 'feet.ogg'] :- Dist < 160, D is round(2*Dist/100.0/0.3048)*50, num(D) == X, !.
distance_mi(Dist) == [ '1.ogg', 'tenth_of_a_mile.ogg'] :- Dist < 241, !.
distance_mi(Dist) == [ X, 'tenths_of_a_mile.ogg'] :- Dist < 1529, rounddiv(Dist, 161, D, E), (nonvar(D), num(D) == X; X=E), !.
distance_mi(Dist) == ['about.ogg', '1.ogg', 'mile.ogg', X] :- Dist < 2414, num_atom(Dist, X), !.
distance_mi(Dist) == ['about.ogg', X, 'miles.ogg'] :- Dist < 16093, D is round(Dist/1609.0), num(D) == X, !.
distance_mi(Dist) == [ X, 'miles.ogg'] :- D is round(Dist/1609.0), num(D) == X, !.

rounddiv(A, B, C, E) :- C is div(A*10+B*10/2, B*10);  E="divide_failed.ogg".
%rounddiv(A, B, C, E) :- (D is (10*A+5)/(B*10), (C is round(D); E="round_failed.ogg"); E="divide_failed.ogg").

%% resolve command main method
%% if you are familar with Prolog you can input specific to the whole mechanism,
%% by adding exception cases.
flatten(X, Y) :- flatten(X, [], Y), !.
flatten([], Acc, Acc).
flatten([X|Y], Acc, Res):- flatten(Y, Acc, R), flatten(X, R, Res).
flatten(X, Acc, [X|Acc]).

resolve(X, Y) :- resolve_impl(X,Z), flatten(Z, Y).
resolve_impl([],[]).
resolve_impl([X|Rest], List) :- resolve_impl(Rest, Tail), ((X == L) -> append(L, Tail, List); List = Tail).
