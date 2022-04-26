module ExampleTemplates where

import Interpretation
import SolveTemplates
    
-------------------------------------- Templates ------------------------------
extension_templates :: [(String, (String, Template, String))]
extension_templates = [
    ("causal_judgement_1.lp", ("data/causal_judgement", template_causal_judgement_1_1, "causal_judgement_1.lp")),
    ("nocausal_judgement_1.lp", ("data/causal_judgement", template_nocausal_judgement_1_1, "causal_judgement_1.lp")),
    ("causal_judgement_2.lp", ("data/causal_judgement", template_causal_judgement_2_1, "causal_judgement_2.lp")),
    ("nocausal_judgement_2.lp", ("data/causal_judgement", template_nocausal_judgement_2_1, "causal_judgement_2.lp")),
    ("heating_1.lp", ("data/causal_judgement", template_heating_1, "heating_1.lp")),
    ("heating_2.lp", ("data/causal_judgement", template_heating_2, "heating_2.lp")),
    ("heating_3.lp", ("data/causal_judgement", template_heating_3, "heating_3.lp")),
    ("conjunction_1.lp", ("data/causal_judgement", template_conjunction_1, "conjunction_1.lp"))
    -- ("figurative_synthesis_1.lp", ("data/figurative_synthesis", template_figurative_synthesis_1, "figurative_synthesis_1.lp"))
   ]

-- eerste is input-argument 'lookup-file'
-- DAN: 'dir, template, input'
misc_templates :: [(String, (String, Template, String))]
misc_templates = [
    ("predict_0.lp", ("data/misc", template_misc_0_1, "predict_0.lp")),
    ("predict_1.lp", ("data/misc", template_misc_1_1, "predict_1.lp")),
    ("predict_2.lp", ("data/misc", template_misc_2_1, "predict_2.lp")),
    ("predict_3.lp", ("data/misc", template_misc_3_1, "predict_3.lp")),
    ("predict_4.lp", ("data/misc", template_misc_4_1, "predict_4.lp")),
    ("predict_judg_4.lp", ("data/misc", template_misc_judg_4_1, "predict_judg_4.lp")),
    ("predict_example.lp", ("data/misc", template_misc_4_mislabel, "predict_example.lp")),
    ("predict_mislabel.lp", ("data/misc", template_misc_4_mislabel, "predict_mislabel.lp")),
    ("exog_1.lp", ("data/misc", template_exog_1, "exog_1.lp")),
    ("first_last_1.lp", ("data/misc", template_first_last_1, "first_last_1.lp")),
    ("first_last_2.lp", ("data/misc", template_first_last_1, "first_last_2.lp")),
    ("first_last_3.lp", ("data/misc", template_first_last_3, "first_last_3.lp")),
    ("first_last_4.lp", ("data/misc", template_first_last_3, "first_last_4.lp")),
    ("first_last_5.lp", ("data/misc", template_first_last_5, "first_last_5.lp")),
    ("first_last_6.lp", ("data/misc", template_first_last_6, "first_last_6.lp")),
    ("second_last_1.lp", ("data/misc", template_second_last_1, "second_last_1.lp")),
    ("second_last_2.lp", ("data/misc", template_second_last_2, "second_last_2.lp"))
    ]


frame_conjunction_1 :: Frame    
frame_conjunction_1 = Frame {
    types = [T "light"],
    type_hierarchy = [],
    objects = [
        (O "sensor_a", T "light")
        ],
    exogeneous_objects = [],
    permanent_concepts = [],
    fluid_concepts = [
        (C "on", [T "light"]), 
        (C "off", [T "light"]),
        (C "black", [T "light"]), 
        (C "green", [T "light"])
        ],
    input_concepts = [C "on", C "off", C "black", C "green"],
    static_concepts = [],
    vars = [
        (V "x", T "light")
        ],
    var_groups = [
        [V "x"]
        ],
    aux_files = []
}

template_conjunction_1 :: Template
template_conjunction_1 = Template {
    dir = "causal_judgement",
    frame = frame_conjunction_1,
    min_body_atoms = 0,
    max_body_atoms = 3, 
    num_arrow_rules = 2,
    num_causes_rules = 2,
    num_visual_predicates = Nothing,
    use_noise = False,
    num_causal_judgements = 2,
    max_head_atoms = 2
    }    

-- WAAR KOMT 'GIVEN' precies stoer doen?
frame_heating_1 :: Frame    
frame_heating_1 = Frame {
    types = [T "rock", T "number"],
    type_hierarchy = [],
    objects = [
        (O "rock_on_floor", T "rock"),
        (O "number_0", T "number"),
        (O "number_1", T "number"),
        (O "number_2", T "number"),
        (O "number_3", T "number"),
        (O "number_4", T "number"),
        (O "number_5", T "number"),
        (O "number_6", T "number"),
        (O "number_7", T "number"),
        (O "number_8", T "number"),
        (O "number_9", T "number")
        ],
    exogeneous_objects = [],
    permanent_concepts = [
        (P "first_number", Given, [T "number"]),
        (P "succ", Given, [T "number", T "number"]),
        (P "less", Given, [T "number", T "number"])],
    fluid_concepts = [
        -- (C "hot", [T "rock"]), 
        -- (C "cold", [T "rock"]),
        (C "temp", [T "rock", T "number"]),
        (C "treshold", [T "number"]),
        (C "shinedon", [T "rock"]),
        (C "notshinedon", [T "rock"])
        ],
    input_concepts = [C "temp", C "treshold", C "shinedon", C "notshinedon"],
    static_concepts = [],
    vars = [
        (V "x", T "rock"),
        (V "y", T "number"),
        (V "z", T "number"),
        (V "w", T "number")
        ],
    var_groups = [
        [V "x", V "y", V "z"], 
        [V "x", V "y"],
        -- [V "y", V "z"],
        -- [V "x", V "z"],
        -- [V "w", V "z"]
        [V "x"],
        [V "y"]
        -- [V "w"]
        ],
    aux_files = ["numbers.lp"]
}

template_heating_1 :: Template
template_heating_1 = Template {
    dir = "causal_judgement",
    frame = frame_heating_1,
    min_body_atoms = 0,
    max_body_atoms = 2, 
    num_arrow_rules = 0,
    num_causes_rules = 0,
    num_visual_predicates = Nothing,
    use_noise = False,
    num_causal_judgements = 4,
    max_head_atoms = 2
    }    



frame_heating_2 :: Frame    
frame_heating_2 = Frame {
    types = [T "rock", T "number"],
    type_hierarchy = [],
    objects = [
        (O "rock_on_floor", T "rock"),
        (O "number_0", T "number"),
        (O "number_1", T "number"),
        (O "number_2", T "number"),
        (O "number_3", T "number"),
        (O "number_4", T "number"),
        (O "number_5", T "number"),
        (O "number_6", T "number"),
        (O "number_7", T "number"),
        (O "number_8", T "number"),
        (O "number_9", T "number")
        ],
    exogeneous_objects = [],
    permanent_concepts = [
        (P "first_number", Given, [T "number"]),
        (P "succ", Given, [T "number", T "number"]),
        (P "less", Given, [T "number", T "number"])],
    fluid_concepts = [
        (C "hot", [T "rock"]), 
        (C "cold", [T "rock"]),
        (C "temp", [T "rock", T "number"]),
        (C "treshold", [T "number"])
        ],
    input_concepts = [C "hot", C "cold", C "temp", C "treshold"],
    static_concepts = [],
    vars = [
        (V "x", T "rock"),
        (V "y", T "number"),
        (V "z", T "number")
        ],
    var_groups = [
        [V "x", V "y", V "z"], 
        [V "x", V "y"],
        [V "x", V "z"],
        [V "y", V "z"],
        [V "x"],
        [V "y"],
        [V "z"]
        ],
    aux_files = ["numbers.lp"]
}

template_heating_2 :: Template
template_heating_2 = Template {
    dir = "causal_judgement",
    frame = frame_heating_2,
    min_body_atoms = 0,
    max_body_atoms = 3, 
    num_arrow_rules = 0,
    num_causes_rules = 0,
    num_visual_predicates = Nothing,
    use_noise = False,
    num_causal_judgements = 1,
    max_head_atoms = 2
    }    


frame_heating_3 :: Frame    
frame_heating_3 = Frame {
    types = [T "rock", T "number"],
    type_hierarchy = [],
    objects = [
        (O "rock_on_floor", T "rock"),
        (O "number_0", T "number"),
        (O "number_1", T "number"),
        (O "number_2", T "number"),
        (O "number_3", T "number"),
        (O "number_4", T "number"),
        (O "number_5", T "number"),
        (O "number_6", T "number")
        -- (O "number_7", T "number"),
        -- (O "number_8", T "number"),
        -- (O "number_9", T "number")
        ],
    exogeneous_objects = [],
    permanent_concepts = [
        (P "first_number", Given, [T "number"]),
        (P "succ", Given, [T "number", T "number"]),
        (P "less", Given, [T "number", T "number"])],
    fluid_concepts = [
        -- (C "hot", [T "rock"]), 
        -- (C "cold", [T "rock"]),
        -- (C "p", [T "rock"]), 
        -- (C "q", [T "rock"]),
        -- (C "r", [T "rock"]),
        (C "temp", [T "rock", T "number"]),
        -- (C "treshold", [T "number"]),
        (C "shinedon", [T "rock"]),
        (C "notshinedon", [T "rock"])
        ],
    -- input_concepts = [C "hot", C "cold", C "temp", C "treshold", C "shinedon", C "notshinedon"],
    -- input_concepts = [C "temp", C "shinedon", C "notshinedon"],
    input_concepts = [C "shinedon", C "notshinedon", C "temp"],
    static_concepts = [],
    vars = [
        (V "x", T "rock"),
        (V "y", T "number"),
        (V "z", T "number")
        -- (V "s", T "shiner")
        ],
    var_groups = [
        [V "x", V "y", V "z"], 
        [V "y", V "z"],
        [V "x", V "y"],
        [V "x"],
        [V "y"]
        ],
    aux_files = ["numbers.lp"]
}

template_heating_3 :: Template
template_heating_3 = Template {
    dir = "causal_judgement",
    frame = frame_heating_3,
    min_body_atoms = 0,
    max_body_atoms = 2, 
    num_arrow_rules = 2,
    num_causes_rules = 2,
    num_visual_predicates = Nothing,
    use_noise = False,
    num_causal_judgements = 2,
    max_head_atoms = 2
    }




frame_causal_judgement_1_1 :: Frame    
frame_causal_judgement_1_1 = Frame {
    types = [T "person", T "looker"],
    type_hierarchy = [(T "person", [T "looker"])],
    objects = [
        (O "sensor_a", T "looker"),
        (O "sensor_b", T "person")
        ],
    exogeneous_objects = [],
    permanent_concepts = [],
    fluid_concepts = [
        (C "on", [T "person"]), 
        (C "off", [T "person"]),
        (C "r", [T "looker", T "person"]),
        (C "nextto", [T "person", T "person"])
        ],
    input_concepts = [C "on", C "off", C "r", C "nextto"],
    static_concepts = [],
    vars = [
        (V "x", T "looker"),
        (V "y", T "person")
        ],
    var_groups = [
        [V "x", V "y"], 
        [V "x"],
        [V "y"]
        ],
    aux_files = []
}


template_causal_judgement_1_1 :: Template
template_causal_judgement_1_1 = Template {
    dir = "causal_judgement",
    frame = frame_causal_judgement_1_1,
    min_body_atoms = 1,
    max_body_atoms = 2, 
    num_arrow_rules = 0,
    num_causes_rules = 2,
    num_visual_predicates = Nothing,
    use_noise = False,
    num_causal_judgements = 3,
    max_head_atoms = 1
    }    

template_nocausal_judgement_1_1 :: Template
template_nocausal_judgement_1_1 = Template {
    dir = "causal_judgement",
    frame = frame_causal_judgement_1_1,
    min_body_atoms = 1,
    max_body_atoms = 2, 
    num_arrow_rules = 3,
    num_causes_rules = 6,
    num_visual_predicates = Nothing,
    use_noise = False,
    num_causal_judgements = 0,
    max_head_atoms = 1
    }


frame_causal_judgement_2_1 :: Frame    
frame_causal_judgement_2_1 = Frame {
    types = [T "person", T "looker", T "grid"],
    type_hierarchy = [(T "object", [T "grid", T "person"])
    ,(T "person", [T "looker"])],
    objects = [
        (O "sensor_a", T "looker"),
        (O "sensor_b", T "person"),
        (O "grid", T "grid")
        ],
    exogeneous_objects = [],
    permanent_concepts = [],
    fluid_concepts = [
        (C "on", [T "person"]), 
        (C "off", [T "person"]),
        (C "r", [T "looker", T "person"]),
        (C "nextto", [T "person", T "person"]),
        (C "nextto", [T "person", T "grid"]),
        (C "part", [T "person", T "grid"])
        ],
    input_concepts = [C "on", C "off", C "r", C "nextto"],
    static_concepts = [],
    vars = [
        (V "x", T "looker"),
        (V "y", T "person"),
        (V "g", T "grid")
        ],
    var_groups = [
        [V "x", V "y"], 
        [V "x"],
        [V "y"],
        [V "g", V "y"]
        ],
    aux_files = []
}


template_causal_judgement_2_1 :: Template
template_causal_judgement_2_1 = Template {
    dir = "causal_judgement",
    frame = frame_causal_judgement_2_1,
    min_body_atoms = 1,
    max_body_atoms = 2, 
    num_arrow_rules = 3,
    num_causes_rules = 2,
    num_visual_predicates = Nothing,
    use_noise = False,
    num_causal_judgements = 3,
    max_head_atoms = 1
    }    

template_nocausal_judgement_2_1 :: Template
template_nocausal_judgement_2_1 = Template {
    dir = "causal_judgement",
    frame = frame_causal_judgement_2_1,
    min_body_atoms = 1,
    max_body_atoms = 2, 
    num_arrow_rules = 3,
    num_causes_rules = 6,
    num_visual_predicates = Nothing,
    use_noise = False,
    num_causal_judgements = 0,
    max_head_atoms = 1
    }











frame_misc_0_1 :: Frame    
frame_misc_0_1 = Frame {
    types = [T "object"],
    type_hierarchy = [],
    objects = [
        (O "sensor_a", T "object")
        ],
    exogeneous_objects = [],
    permanent_concepts = [],
    fluid_concepts = [
        (C "on", [T "object"]), 
        (C "off", [T "object"])
        ],
    input_concepts = [C "on", C "off"],
    static_concepts = [],
    vars = [
        (V "x", T "object")
        ],
    var_groups = [
        [V "x"]
        ],
    aux_files = []
}

template_misc_0_1 :: Template
template_misc_0_1 = Template {
    dir = "misc",
    frame = frame_misc_0_1,
    min_body_atoms = 1,
    max_body_atoms = 1, 
    num_arrow_rules = 0,
    num_causes_rules = 0,
    num_visual_predicates = Nothing,
    use_noise = False,
    num_causal_judgements = 2,
    max_head_atoms = 1
    }    

frame_misc_1_1 :: Frame    
frame_misc_1_1 = Frame {
    types = [T "object"],
    type_hierarchy = [],
    objects = [
        (O "sensor_a", T "object")
        ],
    exogeneous_objects = [],
    permanent_concepts = [],
    fluid_concepts = [
        (C "on", [T "object"]), 
        (C "off", [T "object"])
        ],
    input_concepts = [C "on", C "off"],
    static_concepts = [],
    vars = [
        (V "x", T "object")
        ],
    var_groups = [
        [V "x"]
        ],
    aux_files = []
}

template_misc_1_1 :: Template
template_misc_1_1 = Template {
    dir = "misc",
    frame = frame_misc_1_1,
    min_body_atoms = 1,
    max_body_atoms = 1, 
    num_arrow_rules = 0,
    num_causes_rules = 2,
    num_visual_predicates = Nothing,
    use_noise = False,
    num_causal_judgements = 10,
    max_head_atoms = 1
    }    

frame_misc_2_1 :: Frame
frame_misc_2_1 = Frame {
    types = [T "sensor_1", T "sensor_2", T "cell", T "grid", T "object"],
    type_hierarchy = [
        (T "object", [T "cell", T "grid"]),
        (T "cell", [T "sensor_1", T "sensor_2"])
        ],
    objects = [
        (O "sensor_a", T "sensor_1"),
        (O "sensor_b", T "sensor_2"),
        (O "grid", T "grid")
        ],
    exogeneous_objects = [],
    permanent_concepts = [],
    fluid_concepts = [
        (C "on", [T "sensor_1"]), 
        (C "off", [T "sensor_1"]),
        (C "a", [T "sensor_2"]),
        (C "b", [T "sensor_2"]),
        (C "c", [T "sensor_2"]),
        (C "part", [T "cell", T "grid"])
        ],
    input_concepts = [C "on", C "off", C "a", C "b", C "c"],
    static_concepts = [],
    vars = [
        (V "s1", T "sensor_1"),
        (V "s2", T "sensor_2"),
        (V "c", T "cell"),
        (V "g", T "grid"),
        (V "x", T "object")
        ],
    var_groups = [
        [V "x"],
        [V "s1"],
        [V "s2"],
        [V "c"],
        [V "c", V "g"]
        ],
    aux_files = []
}

template_misc_2_1 :: Template
template_misc_2_1 = Template {
    dir = "misc",
    frame = frame_misc_2_1,
    min_body_atoms = 1,
    max_body_atoms = 1, 
    num_arrow_rules = 0,
    num_causes_rules = 0,
    num_visual_predicates = Nothing,
    use_noise = False,
    num_causal_judgements = 2,
    max_head_atoms = 1
    }    

frame_misc_3_1 :: Frame
frame_misc_3_1 = Frame {
    types = [T "object"],
    type_hierarchy = [],
    objects = [
        (O "sensor_a", T "object")
        ],
    exogeneous_objects = [],
    permanent_concepts = [],
    fluid_concepts = [
        (C "a", [T "object"]), 
        (C "b", [T "object"]),
        (C "c", [T "object"]),
        (C "d", [T "object"])
        ],
    input_concepts = [C "a", C "b", C "c", C "d"],
    static_concepts = [],
    vars = [
        (V "x", T "object")
        ],
    var_groups = [
        [V "x"]
        ],
    aux_files = []
}

template_misc_3_1 :: Template
template_misc_3_1 = Template {
    dir = "misc",
    frame = frame_misc_3_1,
    min_body_atoms = 1,
    max_body_atoms = 1, 
    num_arrow_rules = 0,
    num_causes_rules = 4,
    num_visual_predicates = Nothing,
    use_noise = False,
    num_causal_judgements = 10
    }    

frame_misc_4_1 :: Frame
frame_misc_4_1 = Frame {
    types = [
        T "sensor", 
        T "grid", 
        T "letter",
        T "object"
        ],
    type_hierarchy = [
        (T "object", [T "sensor", T "grid"])
        ],
    objects = [
        (O "sensor", T "sensor"),
        (O "grid", T "grid"),
        (O "letter_a", T "letter"),
        (O "letter_b", T "letter"),
        (O "letter_c", T "letter"),
        (O "letter_d", T "letter"),
        (O "letter_e", T "letter"),
        (O "letter_f", T "letter")
        ],
    exogeneous_objects = [],
    permanent_concepts = [
        (P "succ", Constructed, [T "letter", T "letter"]),
        (P "part", Constructed, [T "sensor", T "grid"])
        ],
    fluid_concepts = [
        (C "letter", [T "sensor", T "letter"])
        ],
    input_concepts = [C "letter"],
    static_concepts = [],
    vars = [
        (V "l", T "letter"),
        (V "l2", T "letter"),
        (V "s", T "sensor")
        ],    
    var_groups = [
        [V "l", V "l2", V "s"]
        ],
    aux_files = []
}

template_misc_4_1 :: Template
template_misc_4_1 = Template {
    dir = "misc",
    frame = frame_misc_4_1,
    min_body_atoms = 2,
    max_body_atoms = 2, 
    num_arrow_rules = 0,
    num_causes_rules = 1,
    num_visual_predicates = Nothing,
    use_noise = False,
    num_causal_judgements = 0
    }   

template_misc_judg_4_1 :: Template
template_misc_judg_4_1 = Template {
    dir = "misc",
    frame = frame_misc_4_1,
    min_body_atoms = 2,
    max_body_atoms = 2, 
    num_arrow_rules = 0,
    num_causes_rules = 1,
    num_visual_predicates = Nothing,
    use_noise = False,
    num_causal_judgements = 1
    }   


frame_misc_5_1 :: Frame    
frame_misc_5_1 = Frame {
    types = [T "object"],
    type_hierarchy = [],
    objects = [
        (O "sensor_a", T "object")
        ],
    exogeneous_objects = [],
    permanent_concepts = [],
    fluid_concepts = [
        (C "on", [T "object"]), 
        (C "off", [T "object"]),
        (C "a", [T "object"]),
        (C "b", [T "object"]),
        (C "c", [T "object"]),
        (C "d", [T "object"])
        ],
    input_concepts = [C "on", C "off"],
    static_concepts = [],
    vars = [
        (V "x", T "object")
        ],
    var_groups = [
        [V "x"]
        ],
    aux_files = []
}

template_misc_5_1 :: Template
template_misc_5_1 = Template {
    dir = "misc",
    frame = frame_misc_5_1,
    min_body_atoms = 1,
    max_body_atoms = 1, 
    num_arrow_rules = 0,
    num_causes_rules = 2,
    num_visual_predicates = Nothing,
    use_noise = False,
    num_causal_judgements = 0
    }    

frame_exog_1 :: Frame    
frame_exog_1 = Frame {
    types = [T "object"],
    type_hierarchy = [],
    objects = [
        (O "a", T "object")
        ],
    exogeneous_objects = [],
    permanent_concepts = [],
    fluid_concepts = [
        (C "on", [T "object"]), 
        (C "off", [T "object"]),
        (C "bong", [T "object"]),
        (C "noop", [T "object"])
        ],
    input_concepts = [C "on", C "off", C "bong", C "noop"],
    static_concepts = [],
    vars = [
        (V "x", T "object")
        ],
    var_groups = [
        [V "x"]
        ],
    aux_files = []
}

template_exog_1 :: Template
template_exog_1 = Template {
    dir = "misc",
    frame = frame_exog_1,
    min_body_atoms = 1,
    max_body_atoms = 1, 
    num_arrow_rules = 0,
    num_causes_rules = 2,
    num_visual_predicates = Nothing,
    use_noise = False,
    num_causal_judgements = 2
    }    

frame_misc_4_mislabel :: Frame    
frame_misc_4_mislabel = Frame {
    types = [T "object"],
    type_hierarchy = [],
    objects = [
        (O "sensor_a", T "object"),
        (O "sensor_b", T "object")
        ],
    exogeneous_objects = [],
    permanent_concepts = [(P "r", Constructed, [T "object", T "object"])],
    fluid_concepts = [
        (C "on", [T "object"]), 
        (C "off", [T "object"]),
        (C "p1", [T "object"]),
        (C "p2", [T "object"]),
        (C "p3", [T "object"])
        ],
    input_concepts = [C "on", C "off"],
    static_concepts = [],
    vars = [
        (V "x", T "object")
        ],
    var_groups = [
        [V "x"]
        ],
    aux_files = []
}

-- Changed 'use noise' to false here. Otherwise Kantian condition 'blind sense' is not applied
template_misc_4_mislabel :: Template
template_misc_4_mislabel = Template {
    dir = "misc",
    frame = frame_misc_4_mislabel,
    min_body_atoms = 1,
    max_body_atoms = 1, 
    num_arrow_rules = 3,
    num_causes_rules = 3,
    num_visual_predicates = Nothing,
    use_noise = False,
    num_causal_judgements = 3
    }   

frame_first_last_1 :: Frame    
frame_first_last_1 = Frame {
    types = [T "sensor"],
    type_hierarchy = [],
    objects = [
        (O "cell_1", T "sensor"),
        (O "cell_2", T "sensor"),
        (O "cell_3", T "sensor")
        ],
    exogeneous_objects = [],
    permanent_concepts = [(P "right", Given, [T "sensor", T "sensor"])],
    fluid_concepts = [
        (C "on", [T "sensor"]), 
        (C "off", [T "sensor"])
        ],
    input_concepts = [C "on", C "off"],
    static_concepts = [],
    vars = [
        (V "x", T "sensor"),
        (V "y", T "sensor")
        ],
    var_groups = [
        [V "x", V "y"]
        ],
    aux_files = ["misc_first_last.lp"]
}

template_first_last_1 :: Template
template_first_last_1 = Template {
    dir = "misc",
    frame = frame_first_last_1,
    min_body_atoms = 1,
    max_body_atoms = 2, 
    num_arrow_rules = 0,
    num_causes_rules = 2,
    num_visual_predicates = Nothing,
    use_noise = False,
    num_causal_judgements = 2
    }    

frame_first_last_3 :: Frame    
frame_first_last_3 = Frame {
    types = [T "sensor"],
    type_hierarchy = [],
    objects = [
        (O "cell_1", T "sensor"),
        (O "cell_2", T "sensor"),
        (O "cell_3", T "sensor")
        ],
    exogeneous_objects = [],
    permanent_concepts = [(P "right", Given, [T "sensor", T "sensor"])],
    fluid_concepts = [
        (C "on", [T "sensor"]), 
        (C "off", [T "sensor"])
        ],
    input_concepts = [C "on", C "off"],
    static_concepts = [],
    vars = [
        (V "x", T "sensor"),
        (V "y", T "sensor")
        ],
    var_groups = [
        [V "x", V "y"]
        ],
    aux_files = ["misc_first_last.lp", "bnn.lp"]
}

template_first_last_3 :: Template
template_first_last_3 = Template {
    dir = "misc",
    frame = frame_first_last_3,
    min_body_atoms = 1,
    max_body_atoms = 2, 
    num_arrow_rules = 0,
    num_causes_rules = 2,
    num_visual_predicates = Nothing,
    use_noise = False,
    num_causal_judgements = 2
    }    

frame_first_last_5 :: Frame    
frame_first_last_5 = Frame {
    types = [T "sensor"],
    type_hierarchy = [],
    objects = [
        (O "cell_1", T "sensor"),
        (O "cell_2", T "sensor"),
        (O "cell_3", T "sensor")
        ],
    exogeneous_objects = [],
    permanent_concepts = [(P "right", Given, [T "sensor", T "sensor"])],
    fluid_concepts = [
        (C "p", [T "sensor"]), 
        (C "q", [T "sensor"])
        ],
    input_concepts = [C "p", C "q"],
    static_concepts = [],
    vars = [
        (V "x", T "sensor"),
        (V "y", T "sensor")
        ],
    var_groups = [
        [V "x", V "y"]
        ],
    aux_files = ["misc_first_last_5.lp", "bnn.lp"]
}

template_first_last_5 :: Template
template_first_last_5 = Template {
    dir = "misc",
    frame = frame_first_last_5,
    min_body_atoms = 1,
    max_body_atoms = 2, 
    num_arrow_rules = 0,
    num_causes_rules = 2,
    num_visual_predicates = Nothing,
    use_noise = False,
    num_causal_judgements = 2
    }        

frame_first_last_6 :: Frame    
frame_first_last_6 = Frame {
    types = [T "sensor", T "space"],
    type_hierarchy = [],
    objects = [
        (O "cell_1", T "sensor"),
        (O "cell_2", T "sensor"),
        (O "cell_3", T "sensor"),
        (O "space_1", T "space"),
        (O "space_2", T "space"),
        (O "space_3", T "space"),
        (O "space_whole", T "space")
        ],
    exogeneous_objects = [],
    permanent_concepts = [
        (P "right", Given, [T "space", T "space"]),
        (P "in", Given, [T "sensor", T "space"]),
        (P "in2", Given, [T "space", T "space"])
        ],
    fluid_concepts = [
        (C "p", [T "sensor"]), 
        (C "q", [T "sensor"])
        ],
    input_concepts = [C "p", C "q"],
    static_concepts = [],
    vars = [
        (V "x", T "sensor"),
        (V "y", T "sensor"),
        (V "s1", T "space"),
        (V "s2", T "space")
        ],
    var_groups = [
        [V "x", V "y"],
        [V "x", V "y", V "s1", V "s2"]
        ],
    aux_files = ["misc_first_last_5.lp", "bnn.lp"]
}

template_first_last_6 :: Template
template_first_last_6 = Template {
    dir = "misc",
    frame = frame_first_last_6,
    min_body_atoms = 1,
    max_body_atoms = 4, 
    num_arrow_rules = 0,
    num_causes_rules = 2,
    num_visual_predicates = Nothing,
    use_noise = False,
    num_causal_judgements = 2
    }      

frame_second_last_1 :: [String] -> Frame    
frame_second_last_1 auxes = Frame {
    types = [T "object", T "cell", T "sensor", T "value"],
    type_hierarchy = [
        (T "object", [T "cell", T "sensor", T "value"])
        ],
    objects = [
        (O "s", T "sensor"),
        (O "a", T "cell"),
        (O "b", T "cell"),
        (O "value_1", T "value"),
        (O "value_2", T "value"),
        (O "value_3", T "value"),
        (O "value_4", T "value"),
        (O "value_5", T "value"),
        (O "value_6", T "value"),
        (O "value_7", T "value"),
        (O "value_8", T "value"),
        (O "value_9", T "value")
        ],
    exogeneous_objects = [],
    permanent_concepts = [
        (P "greater", Given, [T "value", T "value"]),
        (P "left", Given, [T "sensor", T "cell"]),
        (P "right", Given, [T "sensor", T "cell"])
        ],
    fluid_concepts = [
        (C "p", [T "sensor"]), 
        (C "q", [T "sensor"]),
        (C "value", [T "cell", T "value"])
        ],
    input_concepts = [C "value"],
    static_concepts = [],
    vars = [
        (V "s", T "sensor"),
        (V "c1", T "cell"),
        (V "c2", T "cell"),
        (V "v1", T "value"),
        (V "v2", T "value")
        ],
    var_groups = [
        [V "s", V "c1", V "c2", V "v1", V "v2"]
        ],
    aux_files = auxes
}

template_second_last_1 :: Template
template_second_last_1 = Template {
    dir = "misc",
    frame = frame_second_last_1 [],
    min_body_atoms = 1,
    max_body_atoms = 5, 
    num_arrow_rules = 2,
    num_causes_rules = 0,
    num_visual_predicates = Nothing,
    use_noise = False,
    num_causal_judgements = 0
    }        

template_second_last_2 :: Template
template_second_last_2 = Template {
    dir = "misc",
    frame = frame_second_last_1 ["bnn.lp"],
    min_body_atoms = 1,
    max_body_atoms = 5, 
    num_arrow_rules = 2,
    num_causes_rules = 0,
    num_visual_predicates = Nothing,
    use_noise = False,
    num_causal_judgements = 0
    }            