#include "./Minimum-Cost-Perfect-Matching/Graph.h"
#include "ChinesePostman.h"
#include <string>
#include <sstream>
#include <vector>
#include <emscripten/bind.h>

using namespace std;

pair< Graph, vector<double> > ReadWeightedGraph(string graphData)
{
	//Please see Graph.h for a description of the interface
	stringstream file(graphData);

	string s;
	getline(file, s);
	stringstream ss(s);
	int n;
	ss >> n;
	getline(file, s);
	ss.str(s);
	ss.clear();
	int m;
	ss >> m;

	Graph G(n);
	vector<double> cost(m);
	for(int i = 0; i < m; i++)
	{
		getline(file, s);
		ss.str(s);
		ss.clear();
		int u, v;
		double c;
		ss >> u >> v >> c;

		G.AddEdge(u, v);
		cost[G.GetEdgeIndex(u, v)] = c;
	}

	return make_pair(G, cost);
}

string calculate(string graphData) 
{
	string result = "{\n";

	try
	{
	    Graph G;
	    vector<double> cost;
	
	    //Read the graph
	    pair< Graph, vector<double> > p = ReadWeightedGraph(graphData);
	    G = p.first;
	    cost = p.second;

	    //Solve the problem
	    pair< list<int> , double > sol = ChinesePostman(G, cost);

		result += "\tcost: " + to_string(sol.second) + ",\n";

		list<int> s = sol.first;

        //Print edges in the solution
		result += "\tresult: [";
		for(list<int>::iterator it = s.begin(); it != s.end(); it++) {
			result += to_string(*it); 
			if (next(it) != s.end()) { result += ", "; }
		}
		result += "]\n";
	} catch(const char * msg)
	{
		result += "error: '" + string(msg) + "'\n";
	}

	result += "}";

	return result;
}

// Binding code
EMSCRIPTEN_BINDINGS(my_module) {
	emscripten::function("calculate", &calculate);
}
