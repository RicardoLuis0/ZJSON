version "3.2"

#include "ZJSON/Include.zs"

class JSONTest : StaticEventHandler {

	void testString(){
		let j=JSON.parse("\"This is a test\"");
		if(j is "JsonError"){
			ThrowAbortException(JsonError(j).what);
		}else if(!(j is "JsonString")){
			ThrowAbortException("Expected JsonString, got "..j.getClassName());
		}else if(JsonString(j).s!="This is a test"){
			ThrowAbortException("Expected 'This is a test', got '"..JsonString(j).s.."'");
		}
	}

	void testInt(){
		let j=JSON.parse("12345");
		if(j is "JsonError"){
			ThrowAbortException(JsonError(j).what);
		}else if(!(j is "JsonInt")){
			ThrowAbortException("Expected JsonInt, got "..j.getClassName());
		}else if(JsonInt(j).i!=12345){
			ThrowAbortException("Expected '12345', got '"..JsonInt(j).i.."'");
		}
	}

	void testDouble(){
		let j=JSON.parse("123.45");
		if(j is "JsonError"){
			ThrowAbortException(JsonError(j).what);
		}else if(!(j is "JsonDouble")){
			ThrowAbortException("Expected JsonDouble, got "..j.getClassName());
		}else if(JsonDouble(j).d!=123.45){
			ThrowAbortException("Expected '123.45', got '"..JsonDouble(j).d.."'");
		}
	}
	
	void testBool(){
		let j=JSON.parse("true");
		if(j is "JsonError"){
			ThrowAbortException(JsonError(j).what);
		}else if(!(j is "JsonBool")){
			ThrowAbortException("Expected JsonBool, got "..j.getClassName());
		}else if(!JsonBool(j).b){
			ThrowAbortException("Expected 'true', got 'false'");
		}
		j=JSON.parse("false");
		if(j is "JsonError"){
			ThrowAbortException(JsonError(j).what);
		}else if(!(j is "JsonBool")){
			ThrowAbortException("Expected JsonBool, got "..j.getClassName());
		}else if(JsonBool(j).b){
			ThrowAbortException("Expected 'false', got 'true'");
		}
	}
	
	void testNull(){
		let j=JSON.parse("null");
		if(j is "JsonError"){
			ThrowAbortException(JsonError(j).what);
		}else if(!(j is "JsonNull")){
			ThrowAbortException("Expected JsonNull, got "..j.getClassName());
		}
	}
	
	void testObj(){
		let j=JSON.parse("{}");
		JsonElement e;
		uint n;
		if(j is "JsonError"){
			ThrowAbortException(JsonError(j).what);
		}else if(!(j is "JsonObject")){
			ThrowAbortException("Expected JsonObject, got "..j.getClassName());
		}else if((n=JsonObject(j).getKeys().keys.size())!=0){
			ThrowAbortException("Expected empty object, but object has "..n.." elements");
		}
		j=JSON.parse("{'e':{}}");
		if(j is "JsonError"){
			ThrowAbortException(JsonError(j).what);
		}else if(!(j is "JsonObject")){
			ThrowAbortException("Expected JsonObject, got "..j.getClassName());
		}else if((n=JsonObject(j).getKeys().keys.size())!=1){
			ThrowAbortException("Expected object with 1 element, but object has "..n.."elements");
		}else if(!((e=JsonObject(j).get("e")) is "JsonObject")){
			ThrowAbortException("Expected element 'e' to be JsonObject, but element has type "..e.getClassName());
		}
		j=JSON.parse("{'a':0,'b':0,'c':0,'d':0}");
		if(j is "JsonError"){
			ThrowAbortException(JsonError(j).what);
		}else if(!(j is "JsonObject")){
			ThrowAbortException("Expected JsonObject, got "..j.getClassName());
		}else if((n=JsonObject(j).getKeys().keys.size())!=4){
			ThrowAbortException("Expected object with 4 elements, but object has "..n.." elements");
		}
	}
	
	void testArr(){
		let j=JSON.parse("[]");
		JsonElement e;
		uint n;
		if(j is "JsonError"){
			ThrowAbortException(JsonError(j).what);
		}else if(!(j is "JsonArray")){
			ThrowAbortException("Expected JsonArray, got "..j.getClassName());
		}else if((n=JsonArray(j).size())!=0){
			ThrowAbortException("Expected empty array, but array has "..n.." elements");
		}
		
		j=JSON.parse("[[[]]]");
		if(j is "JsonError"){
			ThrowAbortException(JsonError(j).what);
		}else if(!(j is "JsonArray")){
			ThrowAbortException("Expected JsonArray, got "..j.getClassName());
		}else if((n=JsonArray(j).size())!=1){
			ThrowAbortException("Expected array with 1 element, but array has "..n.." elements");
		}else if(!((e=JsonArray(j).get(0)) is "JsonArray")){
			ThrowAbortException("Expected index [0] to be JsonArray, but element has type "..e.getClassName());
		}else if((n=JsonArray(e).size())!=1){
			ThrowAbortException("Expected array in index [0] with 1 element, but array has "..n.." elements");
		}else if(!((e=JsonArray(e).get(0)) is "JsonArray")){
			ThrowAbortException("Expected index [0] of array in index [0] to be JsonArray, but element has type "..e.getClassName());
		}else if((n=JsonArray(e).size())!=0){
			ThrowAbortException("Expected empty array in index [0][0], but array has "..n.." elements");
		}
		
		j=JSON.parse("[1,2,3,4,5,6,7,8,9,10]");
		if(j is "JsonError"){
			ThrowAbortException(JsonError(j).what);
		}else if(!(j is "JsonArray")){
			ThrowAbortException("Expected JsonArray, got "..j.getClassName());
		}else if((n=JsonArray(j).size())!=10){
			ThrowAbortException("Expected array with 10 elements, but array has "..n.." elements");
		}
	}
	
	override void OnRegister(){
		if(sv_test_json){
			testString();
			testInt();
			testDouble();
			testBool();
			testNull();
			testObj();
			testArr();
			console.printf("\n------\n\nAll JSON Tests Passed Sucessfully\n\n------\n\n");
		}
	}
	
}