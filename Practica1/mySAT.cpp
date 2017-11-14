#include <iostream>
#include <stdlib.h>
#include <algorithm>
#include <vector>
using namespace std;

#define UNDEF -1
#define TRUE 1
#define FALSE 0
#define DECISION_MARK 0
#define ACTIVITY_INCREMENT 1.0
#define ACT_INC_UPDATE_RATE 1000

uint numVars;
uint numClauses;
vector<vector<int> > clauses;
vector<int> model;
vector<int> modelStack;
uint indexOfNextLitToPropagate;
uint decisionLevel;

uint numDecisions;
uint numPropagations;
uint numConflicts;

vector<vector<int> > pclauses;
vector<vector<int> > nclauses;

// Activity counter (number of conflicts in which appears)
vector<double> activity;


void readClauses() {
    // Skip comments
    char c = cin.get();
    while (c == 'c') {
	while (c != '\n') c = cin.get();
	c = cin.get();
    }

    // Read "cnf numVars numClauses"
    string aux;
    cin >> aux >> numVars >> numClauses;
    clauses.resize(numClauses);

    pclauses.resize(numVars+1);
    nclauses.resize(numVars+1);

    activity.resize(numVars+1,0.0);

    // Read clauses
    for (uint i = 0; i < numClauses; ++i) {
	int lit;
	while (cin >> lit and lit != 0) {
	    clauses[i].push_back(lit);
	    if (lit > 0) pclauses[lit].push_back(i);
	    else nclauses[-lit].push_back(i);
	    activity[abs(lit)] += ACTIVITY_INCREMENT;
	}
    }
}


int currentValueInModel(int lit) {
    if (lit >= 0) return model[lit];
    else {
	if (model[-lit] == UNDEF) return UNDEF;
	else return 1 - model[-lit]; // returns the value after aplying the negation
    }
}


void setLiteralToTrue(int lit) {
    modelStack.push_back(lit);
    if (lit > 0) model[lit] = TRUE;
    else model[-lit] = FALSE;
}


// When a conflict is found, the activity of all literals in the clause causing
// the conflict is incremented
void updateActivity(const vector<int>& clause) {
    ++numConflicts;

    // Since recent conflicts should be given more importance, the activity of
    // all literals is diminished from time to time
    if ((numConflicts % ACT_INC_UPDATE_RATE) == 0) {
	for (uint i = 1; i <= numVars; ++i)
	    activity[i] /= 2.0;
    }

    for (uint i = 0; i < clause.size(); ++i) {
	int lit = clause[i];
	activity[abs(lit)] += ACTIVITY_INCREMENT;
    }
}


bool propagateGivesConflict () {
    while (indexOfNextLitToPropagate < modelStack.size()) {
	++numPropagations;

	int lit = modelStack[indexOfNextLitToPropagate];
	++indexOfNextLitToPropagate;

	int* clausesToPropagate = lit > 0 ? &nclauses[lit][0] : &pclauses[-lit][0];
	uint size = lit > 0 ? nclauses[lit].size() : pclauses[-lit].size();

	for (uint i = 0; i < size; ++i) {
	    int j = clausesToPropagate[i];

	    bool someLitTrue = false;
	    int numUndefs = 0;
	    int lastLitUndef = 0;

	    for (uint k = 0; not someLitTrue and k < clauses[j].size(); ++k){
		int val = currentValueInModel(clauses[j][k]);
		if (val == TRUE) someLitTrue = true;
		else if (val == UNDEF) {
		    ++numUndefs;
		    lastLitUndef = clauses[j][k];
		}
	    }
	    if (not someLitTrue and numUndefs == 0) { // conflict! all lits false
		updateActivity(clauses[j]);
		return true;
	    }
	    else if (not someLitTrue and numUndefs == 1)
		setLiteralToTrue(lastLitUndef); // unit propagation
	}
    }
    return false;
}


void backtrack() {
    uint i = modelStack.size() -1;
    int lit = 0;
    while (modelStack[i] != DECISION_MARK) { // 0 is the DL mark
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


// Heuristic for finding the next decision literal:
int getNextDecisionLiteral() {
    ++numDecisions;

    // The literal with the highest activity among those variables still
    // undefined in the model is chosen
    double maxActivity = 0.0;
    int mostActiveVar = 0;

    for (uint i = 1; i <= numVars; ++i) {
	if (model[i] == UNDEF) {
	    if (activity[i] >= maxActivity) {
		maxActivity = activity[i];
		mostActiveVar = i;
	    }
	}
    }

    return mostActiveVar; // returns 0 when all literals are defined
}


void checkmodel() {
    for (uint i = 0; i < numClauses; ++i){
	bool someTrue = false;
	for (uint j = 0; not someTrue and j < clauses[i].size(); ++j)
	    someTrue = (currentValueInModel(clauses[i][j]) == TRUE);
	if (not someTrue) {
	    cout << "Error in model, clause is not satisfied:";
	    for (uint j = 0; j < clauses[i].size(); ++j)
		cout << clauses[i][j] << " ";
	    cout << endl;
	    exit(1);
	}
    }
}


void exitWithSatisfiability(bool satisfiable) {
    if (satisfiable) {
	checkmodel();
	cout << "s SATISFIABLE" << endl;
	cout << "c " << numDecisions << " decisions" << endl;
	cout << "c " << numPropagations << " propagations" << endl;
	exit(20);
    }
    else {
	cout << "s UNSATISFIABLE" << endl;
	cout << "c " << numDecisions << " decisions" << endl;
	cout << "c " << numPropagations << " propagations" << endl;
	exit(10);
    }
}


int main() {
    readClauses(); // reads numVars, numClauses and clauses

    model.resize(numVars+1,UNDEF);
    indexOfNextLitToPropagate = 0;
    decisionLevel = 0;

    numDecisions = 0;
    numPropagations = 0;
    numConflicts = 0;

    // Take care of initial unit clauses, if any
    for (uint i = 0; i < numClauses; ++i)
	if (clauses[i].size() == 1) {
	    int lit = clauses[i][0];
	    int val = currentValueInModel(lit);
	    if (val == FALSE) exitWithSatisfiability(false);
	    else if (val == UNDEF) setLiteralToTrue(lit);
	}

    // DPLL algorithm
    while (true) {
	while ( propagateGivesConflict() ) {
	    if ( decisionLevel == 0) exitWithSatisfiability(false);
	    backtrack();
	}

	int decisionLit = getNextDecisionLiteral();
	if (decisionLit == 0) exitWithSatisfiability(true);

	// start new decision level:
	modelStack.push_back(0); // push mark indicating new DL
	++indexOfNextLitToPropagate;
	++decisionLevel;
	setLiteralToTrue(decisionLit); // now push decisionLit on top of the mark
    }
}
