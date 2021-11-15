class placeholder_JsonObjectElement {
	String key;
	placeholder_JsonElement e;
	
	static placeholder_JsonObjectElement make(String key,placeholder_JsonElement e){
		placeholder_JsonObjectElement elem=new("placeholder_JsonObjectElement");
		elem.key=key;
		elem.e=e;
		return elem;
	}
}

class placeholder_JsonObjectKeys {
	Array<String> keys;
}

class placeholder_JsonObject : placeholder_JsonElement {
	const table_size = 256; // rather small for a general hash table, but should be enough for a json object
	private Array<placeholder_JsonObjectElement> table[table_size];
	private uint elems;
	
	static placeholder_JsonObject make(){
		return new("placeholder_JsonObject");
	}
	
	private uint hash(String s){ // djb2 hashing algorithm
		uint h=5381;
		for(uint i=0;i<s.length();i++){
			h=(h*33)+s.byteat(i);
		}
		return h;
	}
	
	private placeholder_JsonElement getFrom(out Array<placeholder_JsonObjectElement> arr,String key){
		for(uint i=0;i<arr.size();i++){
			if(arr[i].key==key){
				return arr[i].e;
			}
		}
		return null;
	}
	
	private bool setAt(out Array<placeholder_JsonObjectElement> arr,String key,placeholder_JsonElement e,bool replace){
		for(uint i=0;i<arr.size();i++){
			if(arr[i].key==key){
				if(replace){
					arr[i].e=e;
				}
				return replace;
			}
		}
		arr.push(placeholder_JsonObjectElement.make(key,e));
		elems++;
		return true;
	}
	
	private bool delAt(out Array<placeholder_JsonObjectElement> arr,String key){
		for(uint i=0;i<arr.size();i++){
			if(arr[i].key==key){
				arr.delete(i);
				elems--;
				return true;
			}
		}
		return false;
	}
	
	placeholder_JsonElement get(String key){
		uint sz=table_size;
		return getFrom(table[hash(key)%sz],key);
	}
	
	void set(String key,placeholder_JsonElement e){
		uint sz=table_size;
		setAt(table[hash(key)%sz],key,e,true);
	}
	
	bool insert(String key,placeholder_JsonElement e){//only inserts if key doesn't exist, otherwise fails and returns false
		uint sz=table_size;
		return setAt(table[hash(key)%sz],key,e,false);
	}
	
	bool delete(String key){
		uint sz=table_size;
		return delAt(table[hash(key)%sz],key);
	}
	
	placeholder_JsonObjectKeys getKeys(){
		placeholder_JsonObjectKeys keys = new("placeholder_JsonObjectKeys");
		for(uint i=0;i<table_size;i++){
			for(uint j=0;j<table[i].size();j++){
				keys.keys.push(table[i][j].key);
			}
		}
		return keys;
	}
	
	bool empty(){
		return elems==0;
	}
	
	void clear(){
		for(uint i=0;i<table_size;i++){
			table[i].clear();
		}
	}
	
	uint size(){
		return elems;
	}
	
	override string serialize(){
		String s;
		s.AppendCharacter(placeholder_JSON.CURLY_OPEN);
		bool first=true;
		for(uint i=0;i<table_size;i++){
			for(uint j=0;j<table[i].size();j++){
				if(!first){
					s.AppendCharacter(placeholder_JSON.COMMA);
				}
				s.AppendFormat("%s:%s",placeholder_JSON.serialize_string(table[i][j].key),table[i][j].e.serialize());
				first=false;
			}
		}
		s.AppendCharacter(placeholder_JSON.CURLY_CLOSE);
		return s;
	}
}
