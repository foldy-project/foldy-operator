package controller

import (
	"github.com/thavlik/foldy-operator/pkg/controller/foldyservice"
)

func init() {
	// AddToManagerFuncs is a list of functions to create controllers and add them to a manager.
	AddToManagerFuncs = append(AddToManagerFuncs, foldyservice.Add)
}
