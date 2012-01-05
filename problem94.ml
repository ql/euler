let per (a:Z.t) (b:Z.t) (c:Z.t) =
  Z.(a + b + c);;

(*
let tr_area_raw (a:Big_int.big_int) (b:Big_int.big_int) (c:Big_int.big_int) =
  let p = (per a b c) /. 2.0 in
    p *. (p-.a) *. (p-.b) *. (p-.c);;

let tr_area (a:Big_int.big_int) (b:Big_int.big_int) (c:Big_int.big_int) =
    sqrt (tr_area_raw a b c);;

let int_tr_area (a:Big_int.big_int) (b:Big_int.big_int) (c:Big_int.big_int) =
  let raw = tr_area_raw a b c in
   raw != Big_int.zero_big_int && Int64.of_Big_int.big_int raw = Int64.mul (Int64.of_Big_int.big_int (sqrt raw)) (Int64.of_Big_int.big_int (sqrt raw));; 
*)


let int_sqrt_4 (a:Z.t) =
  let (dv, rm) = Z.(ediv_rem a ~$4) in
  Z.(rm = ~$0) && Z.(perfect_square dv);;

let int_area (a:Z.t) =
  let a3 = Z.(~$3*a*a - ~$1) in
    let a2 = Z.(~$2*a) in
      if int_sqrt_4 Z.(a3 - a2) then
        per a a (Z.succ a)
      else if int_sqrt_4 Z.(a3 + a2) then
        per a a (Z.pred a)
      else
        Z.zero;;

(*
let int_area (a:Big_int.big_int) =
  if int_tr_area a a (Big_int.succ_big_int c)
  then per a a (Big_int.succ_big_int c)
  else if int_tr_area a a (Big_int.pred_big_int c)
       then per a a (Big_int.pred_big_int c)
       else Big_int.zero_big_int;;
*)

let rec solve ceiling = 
  let rec tail_rec c acc = 
    if Z.(c = ~$3)
    then acc
    else tail_rec (Z.pred c) (Z.(acc + (int_area c)))
  in
    tail_rec ceiling Z.zero;;

Printf.printf "%s\n" (Z.to_string (solve (Z.(~$333_333_333))));;
