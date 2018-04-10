#include <iostream>
#include <stdlib.h>
#include <algorithm>
#include <vector>
#include <ctime>
using namespace std;

#define UNDEF -1
#define TRUE 1
#define FALSE 0

uint numVars;
uint numClauses;
vector<vector<int> > clauses;
vector<int> model;
vector<int> modelStack;
uint indexOfNextLitToPropagate;
uint decisionLevel;

uint nDecisions;
uint nPropagation;
double temps_ini;

vector<int> heuristic;
vector<vector<int> > p_clauses;
vector<vector<int> > n_clauses;

void readClauses( ){
	// Skip comments
	char c = cin.get();
	while (c == 'c') {
		while (c != '\n') c = cin.get();
		c = cin.get();
	}
	// Read "cnf numVars numClauses"
	string aux;
	cin >> aux >> numVars >> numClauses;

 // Inicialiciazión
  clauses.resize(numClauses);
	heuristic.resize(numVars,0);
  n_clauses.resize(numVars + 1);
  p_clauses.resize(numVars + 1);

	// Read clauses
	for (uint i = 0; i < numClauses; ++i) {
		int lit;
		while (cin >> lit and lit != 0){
			clauses[i].push_back(lit);
			if(lit > 0) p_clauses[lit].push_back(i);
			else n_clauses[-lit].push_back(i);
		}
	}

	for(int i = 0; i < numVars; ++i){
		heuristic[i] = p_clauses[i+1].size() + n_clauses[i+1].size();
	}
}



int currentValueInModel(int lit){
	if (lit >= 0) return model[lit];
	else {
		if (model[-lit] == UNDEF) return UNDEF;
		else return 1 - model[-lit];
	}
}


void setLiteralToTrue(int lit){
	modelStack.push_back(lit);
	if (lit > 0) model[lit] = TRUE;
	else model[-lit] = FALSE;
}


bool propagateGivesConflict ( ) {

  bool someLitTrue;
  int numUndefs, lastLitUndef, val;

	while (indexOfNextLitToPropagate < modelStack.size()){
		int lp = modelStack[indexOfNextLitToPropagate];
		vector<int>* aux;     //PUNTERO

		if(lp < 0) aux = &p_clauses[-lp];
		else aux = &n_clauses[lp];

		for (uint i = 0; i < aux->size(); ++i) {
			someLitTrue = false;
			numUndefs = 0;
			lastLitUndef = 0;

			for (uint k = 0; not someLitTrue and k < clauses[(*aux)[i]].size(); ++k){
        val = currentValueInModel(clauses[(*aux)[i]][k]);

        if (val == TRUE) someLitTrue = true;
				else if (val == UNDEF){
						++numUndefs;
						lastLitUndef = clauses[(*aux)[i]][k];
				}
			}

		if (not someLitTrue and numUndefs == 0){
		    ++heuristic[abs(lp)-1];
		    return true; // cnf
	 }
	  else if (not someLitTrue and numUndefs == 1){
		    setLiteralToTrue(lastLitUndef);
		    ++nPropagation;
	  }
  }
  ++indexOfNextLitToPropagate;
  }
  return false;
}

void backtrack(){
	uint i = modelStack.size() -1;
	int lit = 0;
	while (modelStack[i] != 0){ // 0 is the DL mark
		lit = modelStack[i];
		model[abs(lit)] = UNDEF;
		modelStack.pop_back();
		--i;
	}
	// at this point, lit is the last decision
	modelStack.pop_back(); // remove the DL mark
	--decisionLevel;
	indexOfNextLitToPropagate = modelStack.size();
	setLiteralToTrue(-lit);  // reverse last decision
}


//  HEURISTICA
int getNextDecisionLiteral(){
	for (uint i = 1; i <= numVars; ++i)
    if (model[i] == UNDEF) return i;
  return 0; 
}

void checkmodel(){
	for (int i = 0; i < numClauses; ++i){
		bool someTrue = false;
		for (int j = 0; not someTrue and j < clauses[i].size(); ++j)
			someTrue = (currentValueInModel(clauses[i][j]) == TRUE);
		if (not someTrue) {
			cout << "Error in model, clause is not satisfied:";
			for (int j = 0; j < clauses[i].size(); ++j) cout << clauses[i][j] << " ";
			cout << endl;
			exit(1);
		}
	}
}

int main(){
	temps_ini = clock();
	readClauses(); // reads numVars, numClauses and clauses
	model.resize(numVars+1,UNDEF);
	indexOfNextLitToPropagate = 0;
	decisionLevel = 0;
	nDecisions = nPropagation = 0;

	// Take care of initial unit clauses, if any
	for (uint i = 0; i < numClauses; ++i)
		if (clauses[i].size() == 1) {
			int lit = clauses[i][0];
			int val = currentValueInModel(lit);
			if (val == FALSE) {cout << "No satisfactible" << endl; return 10;}
			else if (val == UNDEF) setLiteralToTrue(lit);
		}

	// DPLL algorithm
	while (true) {
		while ( propagateGivesConflict() ) {
			if ( decisionLevel == 0) {
				cout << "No satisfactible" << endl;
				double temps = (double(clock() - temps_ini) / CLOCKS_PER_SEC);
				cout << "Temps total: " << temps << endl;
				cout << "Nombre nDecisions: " << nDecisions << endl;
				cout << "Nombre propagacions/segon: " << nPropagation/temps << endl;
				return 10;
			}
			backtrack();
		}
		int decisionLit = getNextDecisionLiteral();
		if (decisionLit == 0) {
			checkmodel();
			cout << "Satisfactible" << endl;
			double temps = (double(clock() - temps_ini) / CLOCKS_PER_SEC);
			cout << "Temps total: " << temps << endl;
			cout << "Nombre nDecisions: " << nDecisions << endl;
			cout << "Nombre propagacions/segon: " << nPropagation/temps << endl;
			return 20;
		}
		// start new decision level:
		modelStack.push_back(0);  // push mark indicating new DL
		++indexOfNextLitToPropagate;
		++decisionLevel;
		setLiteralToTrue(decisionLit);    // now push decisionLit on top of the mark
	}
}
