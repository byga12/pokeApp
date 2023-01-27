public class MoveWrapper{
	public Integer accuracy;
	public Integer effect_chance;
	public List<cls_effect_entries> effect_entries;
	public Integer id;
	public List<cls_learned_by_pokemon> learned_by_pokemon;
	public String name;
	public Integer power;
	public Integer pp;
	public Integer priority;
	public cls_target target;
	public cls_type type;
    
	public class cls_effect_entries {
		public String effect;
		public cls_language language;
		public String short_effect;
	}
	public class cls_language {
		public String name;
	}
	public class cls_learned_by_pokemon {
		public String name;
		public String url;
	}
	public class cls_target {
		public String name;
	}
	public class cls_type {
		public String name;
	}
	public static MoveWrapper parse(String json){
		return (MoveWrapper) System.JSON.deserialize(json, MoveWrapper.class);
	}
}