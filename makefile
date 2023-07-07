
NATIVE_FLAG = -O3 -m64 -Wall
WASM_FLAG = -O3 -Wall

Matching.o: ./Minimum-Cost-Perfect-Matching/Matching.cpp ./Minimum-Cost-Perfect-Matching/Matching.h ./Minimum-Cost-Perfect-Matching/BinaryHeap.h ./Minimum-Cost-Perfect-Matching/Globals.h ./Minimum-Cost-Perfect-Matching/Graph.h 
	em++ $(WASM_FLAG) -c ./Minimum-Cost-Perfect-Matching/Matching.cpp -o Matching.o

BinaryHeap.o: ./Minimum-Cost-Perfect-Matching/BinaryHeap.h ./Minimum-Cost-Perfect-Matching/BinaryHeap.cpp ./Minimum-Cost-Perfect-Matching/Globals.h
	em++ $(WASM_FLAG) -c ./Minimum-Cost-Perfect-Matching/BinaryHeap.cpp -o BinaryHeap.o

Graph.o: ./Minimum-Cost-Perfect-Matching/Graph.h ./Minimum-Cost-Perfect-Matching/Graph.cpp
	em++ $(WASM_FLAG) -c ./Minimum-Cost-Perfect-Matching/Graph.cpp -o Graph.o

AppCLI.o: AppCLI.cpp Dijkstra.h ./Minimum-Cost-Perfect-Matching/Matching.h ./Minimum-Cost-Perfect-Matching/Graph.h ChinesePostman.h
	g++ $(NATIVE_FLAG) -c AppCLI.cpp -o AppCLI.o

chinese: Matching.o BinaryHeap.o Graph.o AppCLI.o 
	g++ $(NATIVE_FLAG) Matching.o BinaryHeap.o Graph.o AppCLI.o -o chinese

AppWASM.o: AppWASM.cpp Dijkstra.h ./Minimum-Cost-Perfect-Matching/Matching.h ./Minimum-Cost-Perfect-Matching/Graph.h ChinesePostman.h
	em++ $(WASM_FLAG) -c AppWASM.cpp -o AppWASM.o

wasm: Matching.o BinaryHeap.o Graph.o AppWASM.o
	em++ --bind $(WASM_FLAG) Matching.o BinaryHeap.o Graph.o AppWASM.o -o ChinesePostmanProblem.js