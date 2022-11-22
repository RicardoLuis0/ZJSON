class placeholder_JsonObjectElement {
	String key;
	placeholder_JsonElement e;
	
	static placeholder_JsonObjectElement make(String key, placeholder_JsonElement e){
		placeholder_JsonObjectElement elem = new("placeholder_JsonObjectElement");
		elem.key = key;
		elem.e = e;
		return elem;
	}
}

class placeholder_JsonObjectKeys {
	Array<String> keys;
}

class placeholder_JsonObjectTableElement {
	Array<placeholder_JsonObjectElement> kv_for_hash;
}

class placeholder_JsonObject : placeholder_JsonElement {
	const table_size = 256; // rather small for a general hash table, but should be enough for a json object
	private Array<placeholder_JsonObjectTableElement> table;
	private uint elems;
	
	static placeholder_JsonObject make(){
		let obj = new("placeholder_JsonObject");
		obj.table.resize(256);
		for(uint i = 0; i < 256; i++) {
			obj.table[i] = new("placeholder_JsonObjectTableElement");
		}
		return obj;
	}
	
	private uint hash(String s){ // djb2 hashing algorithm
		uint h = 5381;
		for(uint i = 0; i < s.length(); i++){
			h = (h*33) + s.byteat(i);
		}
		return h;
	}
	
	private placeholder_JsonElement getFrom(out Array<placeholder_JsonObjectElement> arr, String key){
        let n = arr.Size();
		for(uint i = 0; i < n; i++){
			if(arr[i].key == key){
				return arr[i].e;
			}
		}
		return null;
	}
	
	private bool setAt(out Array<placeholder_JsonObjectElement> arr, String key, placeholder_JsonElement e, bool replace){
        let n = arr.Size();
		for(uint i = 0; i < n; i++){
			if(arr[i].key == key){
				if(replace){
					arr[i].e = e;
				}
				return replace;
			}
		}
		arr.push(placeholder_JsonObjectElement.make(key, e));
		elems++;
		return true;
	}
	
	private bool delAt(out Array<placeholder_JsonObjectElement> arr, String key){
        let n = arr.Size();
		for(uint i = 0; i < n; i++){
			if(arr[i].key == key){
				arr.Delete(i);
				elems--;
				return true;
			}
		}
		return false;
	}
	
	placeholder_JsonElement Get(String key){
		uint sz = table_size;
		return getFrom(table[hash(key) % sz].kv_for_hash, key);
	}
	
	void Set(String key,placeholder_JsonElement e){
		uint sz = table_size;
		setAt(table[hash(key) % sz].kv_for_hash, key, e, true);
	}
	
	bool Insert(String key,placeholder_JsonElement e){//only inserts if key doesn't exist, otherwise fails and returns false
		uint sz = table_size;
		return setAt(table[hash(key) % sz].kv_for_hash, key, e, false);
	}
	
	bool Delete(String key){
		uint sz = table_size;
		return delAt(table[hash(key) % sz].kv_for_hash, key);
	}
    
	void GetKeysInto(out Array<String> keys){
		keys.Clear();
		for(uint i = 0; i < table_size; i++) {
			let n = table[i].kv_for_hash.size();
			for(uint j = 0; j < n; j++) {
				keys.Push(table[i].kv_for_hash[j].key);
			}
		}
	}
    
	placeholder_JsonObjectKeys GetKeys(){
		placeholder_JsonObjectKeys keys = new("placeholder_JsonObjectKeys");
        GetKeysInto(keys.keys);
		return keys;
	}
    
    deprecated("0.0", "Use IsEmpty Instead") bool empty() {
        return elems == 0;
    }

	bool IsEmpty(){
		return elems == 0;
	}
	
	void Clear(){
		for(uint i = 0; i < table_size; i++){
			table[i].kv_for_hash.clear();
		}
	}
	
	uint size(){
		return elems;
	}
	
	override string serialize(){
		String s;
		s.AppendCharacter(placeholder_JSON.CURLY_OPEN);
		bool first = true;
		for(uint i = 0; i < table_size; i++){
            let n = table[i].kv_for_hash.Size();
			for(uint j = 0; j < n; j++){
				if(!first){
					s.AppendCharacter(placeholder_JSON.COMMA);
				}
				s.AppendFormat("%s:%s", placeholder_JSON.serialize_string(table[i].kv_for_hash[j].key), table[i].kv_for_hash[j].e.serialize());
				first = false;
			}
		}
		s.AppendCharacter(placeholder_JSON.CURLY_CLOSE);
		return s;
	}
}
