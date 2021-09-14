class JsonElementOrError {
}

class JsonElement : JsonElementOrError {
}

class JsonNumber : JsonElement {
}

class JsonInt : JsonNumber {
	int i;
	static JsonInt make(int i=0){
		JsonInt ii=new("JsonInt");
		ii.i=i;
		return ii;
	}
}

class JsonDouble : JsonNumber {
	double d;
	static JsonDouble make(double d=0){
		JsonDouble dd=new("JsonDouble");
		dd.d=d;
		return dd;
	}
}

class JsonBool : JsonElement {
	bool b;
	static JsonBool make(bool b=false){
		JsonBool bb=new("JsonBool");
		bb.b=b;
		return bb;
	}
}

class JsonString : JsonElement {
	string s;
	static JsonString make(string s=""){
		JsonString ss=new("JsonString");
		ss.s=s;
		return ss;
	}
}

class JsonNull : JsonElement {
	static JsonNull make(){
		return new("JsonNull");
	}
}

class JsonError : JsonElementOrError {
	String what;
	static JsonError make(string s){
		JsonError e=new("JsonError");
		e.what=s;
		return e;
	}
}