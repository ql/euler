module ZSet = Set.Make( 
  struct
    let compare = Z.compare
    type t = Z.t
  end )

let prob_ceiling = Z.(of_int 1_000_000);;

let sum l =
  List.fold_left Z.add Z.zero l;;

let min l =
  List.fold_left Z.min (List.hd l) l;;

let prod l =
  List.fold_left Z.mul Z.one l;;

let uniq l =
  List.fold_left (fun a x -> if List.mem x a then a else x :: a) [] l;;

let count ls elem =
  List.fold_left (fun a x -> if x = elem then a + 1 else a) 0 ls;;

let proper_divisors (a:Z.t) = 
  let rec divisors (next_div:Z.t) acc =  
    if Z.(next_div < ~$2) then
      uniq (List.append (Z.(~$1) :: acc) (List.map (fun x -> Z.(a /x)) acc))
    else
      if Z.(rem a next_div = ~$0) then
        divisors (Z.pred next_div) (next_div :: acc)
      else
        divisors (Z.pred next_div) acc
  in
    divisors (Z.sqrt a) [];;

(*let global_filter = ref (List.map Z.of_int [138; 276; 306; 396; 552; 564; 660; 696; 780; 828; 888; 966; 996]);; *)
let global_filter = ref ZSet.empty;;

let erato_sieve (n:Z.t) =
  let z2i = Z.to_int in
  let arr = Array.make (z2i n) Z.zero in
  let populate_arr arr = 
    for i = 2 to (z2i n) do
      arr.(i-2) <- Z.(of_int i)
    done
  in
  let first_gt_p arr x =
    let rec iter1 arr i =
      if i = n then
        Z.minus_one
      else
        if Z.(arr.(z2i i) > x) then
          arr.(z2i i)
        else
          iter1 arr (Z.succ i)
    in
      iter1 arr Z.zero
  in
  let strike arr x =
    let i = ref Z.(x- ~$2) in
      while Z.(!i < (pred n)) do
        if Z.(arr.(z2i !i) mod x = zero) then (arr.(z2i !i) <- Z.zero); i := Z.(!i + x);
      done
  in
    let rec iter p acc =
      if Z.(p > n) || Z.(p = minus_one) then 
        List.rev acc
      else
        let () = strike arr p in iter (first_gt_p arr p) (p :: acc)
    in
      let () = populate_arr arr in iter Z.(~$2) [];;

let primes = erato_sieve Z.(prob_ceiling / ~$2);;
Printf.printf "primes done\n%!";;

let rec permutations xs level = 
  if xs = [] || level = 0 then
    []
  else
    if level = 1 then
      List.map (fun x -> [x]) xs
    else 
      List.append 
        (let head = List.hd xs in
          List.fold_left (fun a x -> (head :: x) :: a) [] (permutations (List.tl xs) (level-1)))
        (permutations (List.tl xs) level);;

let prime_factors (n:Z.t) =
  let basic_factors = List.filter (fun x -> x < n && Z.(n mod x = zero)) (primes) in
    let rec iter (n:Z.t) factors acc = 
      if factors = [] then
        List.rev acc
      else
        if Z.(n mod (List.hd factors) = zero) then
          iter Z.(n / (List.hd factors)) factors ((List.hd factors) :: acc)
        else
          iter n (List.tl factors) acc
    in
      iter n basic_factors [];; 

let all_divisors (n:Z.t) =
  let p_f = prime_factors n in
    let rec iter (i:int) acc =
      if i = 0 then
        acc
      else
        iter (i-1) ((permutations p_f i) :: acc)
    in
      if p_f = [] then
        if n = Z.one then [Z.one] else [Z.one; n]
      else
        Z.one :: (uniq (List.map prod (List.fold_left List.append [] (iter ((List.length p_f) - 1) []))));; 

let sigma n =
  let factors = prime_factors n in
    Z.sub
      (List.fold_left
        (fun a x -> 
          let xpow = ((count factors x) + 1) in
          Z.(a * (pred (pow x xpow)) / (pred x)))
        Z.one
        (uniq factors))
      n;;

(*
let spd (a:int) (n:int) =
  let rec iter acc n =
    if Z.(n = zero)
    then acc
    else iter (sum (pd acc)) (Z.pred n)
  in iter (Z.of_int a) (Z.of_int n);;
    
let index el els =
  let rec iter el els i =
    if List.hd els = el
    then i
    else iter el (List.tl els) i + 1
  in 
    if List.mem el els 
    then iter el els 0
    else -1;;
*)
let pd = all_divisors;;

let spd_hash = Hashtbl.create (Z.to_int prob_ceiling);;

let spd x =
  if Hashtbl.mem spd_hash x
  then Hashtbl.find spd_hash x
  else 
    let s = sigma x
    in 
      (Hashtbl.add spd_hash x s); s;;

let rec cut el els =
  if List.hd els = el
  then els
  else cut el (List.tl els);;

let chain a =
  let rec iter acc x = 
    let nextx = (spd x) in 
    if Z.(nextx > ~$1_000_000) || (ZSet.mem nextx !global_filter) then
      let () = 
        Printf.printf "skipping %s (come to %s)\n%!" (Z.to_string a) (Z.to_string x); 
        (List.iter (fun x -> global_filter := ZSet.add nextx !global_filter) acc) in 
      []
    else
      (* let () = Printf.printf "%s\n%!" (Z.to_string x) in *)
      if (List.mem x acc)
      then cut x (List.rev acc)
      else 
        iter (x :: acc) nextx
  in
    (* let () = Printf.printf "chain %s\n%!" (Z.to_string a) in *) iter [] a;;


let solve x = 
  let find_longest lists =
    List.fold_left (fun a x -> if List.length a < List.length x then x else a) [] lists
  in
    let chains y =
      let rec iter i acc = 
        if Z.(i > y)
        then List.rev acc
        else iter (Z.succ i) (chain i :: acc)
      in
        iter Z.(~$1) []
    in
      min (find_longest (chains (Z.of_int x)));;

let test_spd x =
  let rec iter i dummy =
    if i > x
    then Z.zero
    else iter (Z.succ i) (spd i)
  in
    iter (Z.of_int 1) Z.zero;;
  
(*
let solve x = 
  let find_longest lists =
    List.fold_left (fun a x -> if List.length a < List.length x then x else a) [] lists
  in
    let chains y =
      let rec iter i acc = 
        if Z.(i > y)
        then let () = Printf.printf "done\n" in List.rev acc
        else let () = Printf.printf "making chain of %s\n" Z.(to_string i);
    Printf.printf "%!" in iter (Z.succ i) (chain i :: acc)
      in
        iter Z.(~$1) []
    in
      chains (Z.of_int x);;
*)

let rec nums x i = 
  if i = 0 then
    x
  else
    nums (sum (pd x)) (i-1);;

Printf.printf "finally! %s\n" (Z.to_string (solve 1_000_000));;
