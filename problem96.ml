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
    for j1 = 1 to 3 do
      r := List.append !r (get (get sudoku j2) j1)
    done; !r;;


hor l 2 2 1 3;;
