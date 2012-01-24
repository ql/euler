module IntSet = Set.Make( 
  struct
    let compare = compare
    type t = int
  end );;

let l = [[[[0;0;3];
  [9;0;0];
  [0;0;1]];
          [[0;2;0];
          [3;0;5];
          [8;0;6]];
                   [[6;0;0];
                    [0;0;1];
                    [4;0;0]]]
;[[[0;0;8];
  [7;0;0];
  [0;0;6]];
          [[1;0;2];
           [0;0;0];
           [7;0;8]];
                    [[9;0;0];
                     [0;0;8];
                     [2;0;0]]];
[[[0;0;2];
[8;0;0];
[0;0;5]];
        [[6;0;9];
        [2;0;3];
        [0;1;0]];
                [[5;0;0];
                [0;0;9];
                [3;0;0]]]];;

let get ls i = match i with
   1 -> List.hd ls
  |2 -> List.hd (List.tl ls)
  |3 -> List.hd (List.tl (List.tl ls));;

let tr square i j =
  get (get square j) i;;

tr l 1 1;;

let el sudoku i1 j1 i2 j2 =
  tr (tr sudoku i1 j1) i2 j2;;

el l 3 1 1 3;;

let hor sudoku _ j1 _ j2 =
  let r = ref [] in
    let target_hor = get sudoku j1 in
      for i1 = 1 to 3 do
        r := List.append !r (get (get target_hor i1) j2)
      done; !r;;

hor l 1 1 1 1;;

let ver sudoku (i1:int) _ (i2:int) _ =
  let r = ref [] in
    for j1 = 1 to 3 do
      for j2 = 1 to 3 do
      r := (tr (tr sudoku i1 j1) i2 j2) :: !r
      done
    done; !r;;

let cell sudoku (i1:int) (j1:int) =
  List.flatten (tr sudoku i1 j1);;

let numbers = List.fold_right IntSet.add [1;2;3;4;5;6;7;8;9] IntSet.empty;;

let s2l set =
  IntSet.fold (fun x a -> x :: a) set [];;
  

let variants sudoku i1 j1 i2 j2 = 
  let s = sudoku in
  if ((el s i1 j1 i2 j2) != 0) then
    [-(el s i1 j1 i2 j2)]
  else
    let candidates = (List.append (List.append (hor s i1 j1 i2 j2) (ver s i1 j1 i2 j2)) (cell s i1 j1)) in 
      s2l (List.fold_left (fun x a -> IntSet.remove a x) numbers candidates);;
  

let all_variants l =
  let q = ref [] in 
    for j1 = 1 to 3 do
      for i1 = 1 to 3 do
        for j2 = 1 to 3 do
          for i2 = 1 to 3 do
            Printf.printf "(%d,%d,%d,%d) -> %d\n" i1 j1 i2 j2 (el l i1 j1 i2 j2);
            q := (variants l i1 j1 i2 j2) :: !q
          done
        done
      done
    done; List.rev !q;;

let valid l =
  not (List.mem 0 (List.map List.length (all_variants l)));;

let solved l =
  not (List.mem 0 (List.flatten (List.flatten (List.flatten l))));;

variants l 1 2 2 3;;

let solve l =
  if (solved l) then
    l
  else if (valid l) then
         solve (step_forward l)
       else
         solve (step_forward l)

  ;;
