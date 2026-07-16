package p

import (
        "fmt"
        "net/http"
        "time"
)

// Deliberately slow startup - sleeping 10s on init to simulate a heavy
// dependency load. This is what makes the cold start actually visible
// on the first request, before --min-instances fixes it.
func init() {
        time.Sleep(10 * time.Second)
}

func HelloWorld(w http.ResponseWriter, r *http.Request) {
        fmt.Fprint(w, "Slow HTTP Go in GCF 2nd gen!")
}