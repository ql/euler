package main
import(
  "fmt"
)

func main() {
  const MULTIPLIER = 28433 
  const POWER = 7830457
  const DIGITS = 10000000000

  var m uint64 = 1
  for i := 0; i < POWER; i ++ {
    m <<= 1
    m = m % DIGITS
  }
  fmt.Println("Hello!", m)
  m = ((m * MULTIPLIER) % DIGITS) + 1
  fmt.Println("Hello!", m)
}
