public class PokemonWrapper{
	public List<cls_abilities> abilities;
	public Integer height;
	public Integer id;
	public List<cls_moves> moves;
	public String name;
	public cls_sprites sprites;
	public List<cls_stats> stats;
	public List<cls_types> types;
	public Integer weight;
    
	public class cls_abilities {
		public cls_ability ability;
	}
	public class cls_ability {
		public String name;
		public String url;
	}
	public class cls_moves {
		public cls_move move;
	}
	public class cls_move {
		public String name;
		public String url;
	}
	public class cls_sprites {
		public String front_default;
	}
	public class cls_stats {
		public Integer base_stat;
		public cls_stat stat;
	}
	public class cls_stat {
		public String name;
	}
	public class cls_types {
		public cls_type type;
	}
	public class cls_type {
		public String name;
		public String url;
	}
	public static PokemonWrapper parse(String json){
		return (PokemonWrapper) System.JSON.deserialize(json, PokemonWrapper.class);
	}
}