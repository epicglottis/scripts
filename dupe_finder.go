// Learning Golang...

package main

import "fmt"
//import "hash/crc32"  // TODO: This is probably faster
import "crypto/md5"
import "io"
import "os"
import "path/filepath"

var m = make(map[string]string)

func main() {
    if len(os.Args) <= 1 {
        fmt.Printf("You must specify a path")
        fmt.Fprintf(os.Stderr, "usage: %s <directory>\n", os.Args[0])
        os.Exit(2)
    }
    root := os.Args[1]
    fmt.Printf("Scanning path(s):%s\n", root)
    filepath.Walk(root, walkpath)
}

func FileMd5Hash(filePath string) (string, error) {
  var result []byte
  file, err := os.Open(filePath)
  if err != nil {
    return "", err
  }
  defer file.Close()

  hash := md5.New()
  if _, err := io.Copy(hash, file); err != nil {
    return "", err
  }
  return fmt.Sprintf("%s", hash.Sum(result)), nil
}

func walkpath(path string, f os.FileInfo, err error) error {
  if f.IsDir() {
    return nil
  }

  hash, err := FileMd5Hash(path)
  _, ok := m[hash]
  if ok {
    fmt.Printf("DUPLICATE!\n1: %s\n2: %s\n\n", path, m[hash])
  } else {
    m[hash] = path
  }

  return nil
}
