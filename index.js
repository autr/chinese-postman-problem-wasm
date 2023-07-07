import loadCPP from './ChinesePostmanProblem.mjs'


let cpp = null
export default async ( numVertices, numEdges, tupleConnections ) => {

	if (!cpp) cpp = await loadCPP()

	const strCommand = `${numVertices}\n${numEdges}\n${tupleConnections.map( tup => {
		return Array.isArray(tup) ? tup.join(' ') : `${tup.from} ${tup.to} ${tup.cost}`
	}).join('\n')}`


	console.log(`[ChinesePostmanProblem] 🌐 calculating ${tupleConnections.length} edges`)


	try {
		const res = cpp.calculate( strCommand )

		console.log(`[ChinesePostmanProblem] ✅ received ${res}`)
		return JSON.parse(res)
	} catch(err) {
		console.log(`[ChinesePostmanProblem] ❌ ${err?.message || err}`)
		return null
	}
}