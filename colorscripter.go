package main

import (
        "fmt"
        "image"
        "log"
        "os"

        _ "image/gif"
        _ "image/jpeg"
        _ "image/png"
)

func main() {
        if len(os.Args) < 2 {
                fmt.Fprintf(os.Stderr, "usage: %s [imagefile]\n", os.Args[0])
                os.Exit(2)
        }

        var squishMode = false
        if len(os.Args) == 3 && os.Args[2] == "squish" {
                squishMode = true
        }

        reader, err := os.Open(os.Args[1])
        if err != nil {
                log.Fatal(err)
        }
        defer reader.Close()

        m, _, err := image.Decode(reader)
        if err != nil {
                log.Fatal(err)
        }
        bounds := m.Bounds()

        for y := bounds.Min.Y; y < bounds.Max.Y; y++ {
                for x := bounds.Min.X; x < bounds.Max.X; x++ {
                        r, g, b, a := m.At(x, y).RGBA()
                        if squishMode == true && y%2 == 0 {
                                continue
                        }
                        r = r >> 12
                        g = g >> 12
                        b = b >> 12
                        a = a >> 12
                        if a > 0 {
                                if r > b && r > g {
                                        fmt.Printf("\033[31m" + "█" + "\033[0m")
                                } else if b > r && b > g {
                                        fmt.Printf("\033[34m" + "█" + "\033[0m")
                                } else if g > r && g > b {
                                        fmt.Printf("\033[32m" + "█" + "\033[0m")
                                } else if r == g && r > b {
                                        fmt.Printf("\033[33m" + "█" + "\033[0m")
                                } else if r == b && r > g {
                                        fmt.Printf("\033[35m" + "█" + "\033[0m")
                                } else if r == b && r == g && (r == 15 || r == 14 || r == 13) {
                                        fmt.Printf("\033[0m" + "█" + "\033[0m")
                                } else if r == b && r == g && (r == 0 || r == 1 || r == 2) {
                                        fmt.Printf("\033[30m" + "█" + "\033[0m")
                                } else {
                                        fmt.Printf(" ")
                                        // fmt.Printf("<%d|%d|%d>", r, g, b)
                                }
                        } else {
                                fmt.Printf(" ")
                        }
                }
                // Squish mode:
                if squishMode == true {
                        if y%2 != 0 {
                                fmt.Printf("\n")
                        }
                } else {
                        fmt.Printf("\n")
                }
        }
        fmt.Printf("\n")

        //      fmt.Printf("\033[31m" + "This is red!" + "\033[0m\n")
        //      fmt.Printf("\033[32m" + "This is green!" + "\033[0m\n")
        //      fmt.Printf("\033[33m" + "This is yellow!" + "\033[0m\n")
        //      fmt.Printf("\033[34m" + "This is blue!" + "\033[0m\n")
        //      fmt.Printf("\033[35m" + "This is purple!" + "\033[0m\n")
        //      fmt.Printf("\033[36m" + "This is cyan!" + "\033[0m\n")
        //      fmt.Printf("\033[30m" + "This is black!" + "\033[0m\n")
        //      fmt.Printf("\033[0m" + "This is white!" + "\033[0m\n")
}
