package main

import (
	"bufio"
	"fmt"
	"io/ioutil"
	"net/http"
	"os"
	"strings"
)

func main() {

	fmt.Println("http: 1")
	fmt.Println("https: 2")
	// inputReader := bufio.NewReader(os.Stdin)
	// input, _ := inputReader.ReadString('\n')

	file, _ := os.Open("./list")
	// if err != nil {
	// 	log.Fatal(err)
	// }
	// defer file.Close()
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		// fmt.Println(scanner.Text())

		resp, _ := http.Get("http://" + scanner.Text())
		body, _ := ioutil.ReadAll(resp.Body)
		// fmt.Println(string(body))
		fmt.Println(strings.Contains(string(body), "龍門"))
		if strings.Contains(string(body), "龍門") {
			println(scanner.Text(), resp.StatusCode, http.StatusText(resp.StatusCode))
		} else {
			println(scanner.Text(), resp.StatusCode)

		}

	}
}
