package controller

import (
	"github.com/foldy-project/foldy-operator/foldy-operator/pkg/controller/transform"
)

func init() {
	// AddToManagerFuncs is a list of functions to create controllers and add them to a manager.
	AddToManagerFuncs = append(AddToManagerFuncs, transform.Add)
}
