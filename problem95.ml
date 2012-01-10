module ZSet = Set.Make( 
  struct
    let compare = Z.compare
    type t = Z.t
  end )

let prob_ceiling = Z.(of_int 1000_000);;

let sum l =         List.fold_left Z.add Z.zero l;;
let min l =         List.fold_left Z.min (List.hd l) l;;
let prod l =        List.fold_left Z.mul Z.one l;;
let uniq l =        List.fold_left (fun a x -> if List.mem x a then a else x :: a) [] l;;
let count ls elem = List.fold_left (fun a x -> if x = elem then a + 1 else a) 0 ls;;

(*let global_filter = ref (List.map Z.of_int [138; 276; 306; 396; 552; 564; 660; 696; 780; 828; 888; 966; 996]);; *)
let global_filter = ref ZSet.empty;;
List.iter (fun x -> global_filter := ZSet.add (Z.of_int x) !global_filter) [138; 276; 306; 396; 552; 564; 660; 696; 780; 828; 888; 966; 996];;

let erato_sieve (n:Z.t) =
  let z2i = Z.to_int in
  let arr = Array.make (z2i n) Z.zero in
  let () = for i = 2 to (z2i n) do
      arr.(i-2) <- Z.(of_int i)
    done
  in
  let len = (Array.length arr)-1 in
    for i = 0 to len do
      if Z.(arr.(i) != zero) then 
        let p = Z.to_int arr.(i) in
          begin 
            let j = ref (i + p) in 
            while !j <= len do begin
              arr.(!j) <- Z.zero;
              j := !j + p
            end done
          end
    done; 
    List.rev (Array.fold_left (fun a x -> if x = Z.zero then a else x :: a) [] arr);;

let primes = erato_sieve prob_ceiling;;
Printf.printf "primes done\n%!";;

let prime_factors (x:Z.t) =
  let (acc, n, f) = (ref [], ref x, ref primes) in
    while Z.(!n > one) do
      if Z.(!n mod (List.hd !f) = zero) then
        begin
          acc := (List.hd !f) :: !acc;
          n := Z.(!n / (List.hd !f))
        end
      else
        f := List.tl !f
    done;
  List.rev !acc;;

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

let spd_hash = Hashtbl.create (Z.to_int prob_ceiling);;

let spd x =
  if Hashtbl.mem spd_hash x
  then Hashtbl.find spd_hash x
  else 
    let s = sigma x
    in 
      (Hashtbl.add spd_hash x s); s;;

let cut el els =
  let i = ref els in
    while !i != [] && (List.hd !i != el) do
      i := List.tl !i
    done; !i;;

let chain a =
  let rec iter acc x = 
    let nextx = (spd x) in 
    if Z.(nextx > ~$1_000_000) || (ZSet.mem nextx !global_filter) then
      let () = 
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

Printf.printf "finally! %s\n" (Z.to_string (solve 1_000_000));;
