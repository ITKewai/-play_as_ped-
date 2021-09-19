Config = {}

Config.Staff_identifier = { -- Should work with any license
    "steam:1100001183c1e41", -- KEWAI
    "steam:1100001156c097f", -- Lello
    "steam:110000103c621d3", -- Dom
    "7a94e2fcecd3d42a3244fb5e72a521fc7666eb7f", -- kewai offline
    "steam:1100001438a6987", -- Mammo
    "steam:11000010c07a95e", -- Magix
    "steam:110000103d860aa", -- Kobra
    "steam:1100001150c5c7d", -- Focaccina
}

Config.Staff_god_mode = true -- immortalità a proiettili ecc *solo quando non hai il ped default
Config.Staff_unlimited_stamina = true -- stamina illimitata per correre *solo quando non hai il ped default

Config.GruppoPedModificati = {
    {label = 'Default',            value = 1,  ped = "human"},
    {label = 'Bambino Mafioso',    value = 2, ped = "Child"},
    {label = 'Dante Default',      value = 3, ped = "Dante"},
    {label = 'Dante Nero',         value = 4, ped = "Paolino"},
    {label = 'Dante Castano',      value = 5, ped = "dante2"},
    {label = 'Ragazzino Trans',    value = 6, ped = "abner"},
    {label = 'Neonato',            value = 7, ped = "skin_baby"},
    {label = 'Batman',             value = 8, ped = "BatmanBVS"},
    {label = 'Groot Medio',        value = 9, ped = "minibabygroot"},
    {label = 'Groot Piccolo',      value = 10, ped = "littlegroot"},
    {label = 'Toretto',            value = 11, ped = "u_m_m_aldinapoli"},
    {label = 'Ghostface',          value = 12, ped = "Ghostface"},
    {label = 'Deadpool',           value = 13, ped = "Deadpool"},
    {label = 'Alex Intellettuale', value = 14, ped = "alex_weiss"},
    {label = 'Spiderman',          value = 15, ped = "Spiderman_Raimi_PS4"},

}

Config.Animali = {
    {label = 'Default',            value = 1,  ped = "human"},
    {label = 'Gatto',              value = 2,  ped = "a_c_cat_01"},
    {label = 'Barboncino',         value = 3,  ped = "a_c_pug"},
    {label = 'Poodle',             value = 4,  ped = "a_c_poodle"},
    {label = 'Westy',              value = 5,  ped = "a_c_westy"},
    {label = 'Aquila',             value = 6,  ped = "a_c_chickenhawk"},
    {label = 'Mucca',              value = 7,  ped = "a_c_cow"},
    {label = 'Maiale',             value = 8, ped = "a_c_pig"},
    {label = 'Piccione',           value = 9, ped = "a_c_pigeon"},
    {label = 'Husky',              value = 10, ped = "a_c_husky"},
    {label = 'Retriver',           value = 11, ped = "a_c_retriever"},
    {label = 'Rottweiler',         value = 12, ped = "a_c_rottweiler"},
    {label = 'Shepherd',           value = 13, ped = "a_c_shepherd"},
    {label = 'Scimmia',            value = 14, ped = "a_c_chimp"},
    {label = 'Leonessa',           value = 15, ped = "a_c_mtlion"},
    {label = 'Topo',               value = 16, ped = "a_c_rat"},
    {label = 'Cervo',              value = 17, ped = "a_c_deer"},
    {label = 'Coyote',             value = 18, ped = "a_c_coyote"},
}

Config.GruppoPedNormali ={
    {label = 'Default',            value = 1,  ped = "human"},
    {label = 'Jesu',               value = 2, ped = "u_m_m_jesus_01"},
    {label = 'Robot',              value = 3, ped = "u_m_y_juggernaut_01"},
    {label = 'Tipo Barbuto',       value = 4, ped = "a_m_m_hasjew_01"},
    {label = 'Uomo Mascherato',    value = 5, ped = "mp_m_bogdangoon"},
    {label = 'Uomo Scimmia',       value = 6, ped = "u_m_m_streetart_01"},
    {label = 'Uomo Sciammia2',     value = 7, ped = "u_m_y_pogo_01"},
    {label = 'Alieno',             value = 8, ped = "s_m_m_movalien_01"},
    {label = 'Astronauta',         value = 9, ped = "s_m_m_movspace_01"},
    {label = 'Big Foot',           value = 10, ped = "cs_orleans"},
    {label = 'Uomo senza Testa',   value = 11, ped = "ig_johnnyklebitz"},
    {label = 'Prete',              value = 12, ped = "cs_priest"},
}

-- LATO UTENTE
Config.MenuUtente = {
    {label = 'Imposta Ped',            value = 1,  ped = "nohuman"},
    {label = 'Torna Umano',              value = 2,  ped = "human"},
}


Config.User_peds = {
    { identifier = 'steam:110000146f8e1e0', ped = 'cs_priest' }, -- prete
    { identifier = 'steam:11000011b922100', ped = 'u_m_m_partytarget' }, -- MOD mike
    { identifier = 'steam:11000013c1a0654', ped = 'u_m_m_filmdirector' }, -- MOD gennaro
    { identifier = 'steam:110000143ea321e', ped = 's_m_y_mime' }, -- MOD santanta
    { identifier = 'steam:110000110e27edc', ped = 'u_m_y_juggernaut_01' }, -- MOD teogreg
    { identifier = 'steam:1100001150c5c7d', ped = 'u_m_m_jesus_01' }, -- Focaccina (ped mortale)
    { identifier = 'steam:110000142f3447c', ped = 's_m_y_casino_01' }, -- MOD basca
}




--[[local elements = {
    {label = 'Human',            value = 1,  ped = "human"},
    {label = 'Cat',              value = 2,  ped = "a_c_cat_01"},
    {label = 'Pug',              value = 3,  ped = "a_c_pug"},
    {label = 'Poodle',           value = 4,  ped = "a_c_poodle"},
    {label = 'Westy',            value = 5,  ped = "a_c_westy"},
    {label = 'Bird',             value = 6,  ped = "a_c_chickenhawk"},
    {label = 'Cow',              value = 7,  ped = "a_c_cow"},
    {label = 'Pig',              value = 8, ped = "a_c_pig"},
    {label = 'Pigeon',           value = 9, ped = "a_c_pigeon"},
    {label = 'Husky',            value = 10, ped = "a_c_husky"},
    {label = 'Retriver',         value = 11, ped = "a_c_retriever"},
    {label = 'Poddle',           value = 12, ped = "a_c_poodle"},
    {label = 'Rottweiler',       value = 13, ped = "a_c_rottweiler"},
    {label = 'Shepherd',         value = 14, ped = "a_c_shepherd"},
}]]

--Config = {}
--Config.User_peds = {
--    { identifier = 'steam:110000146f8e1e0', ped = 'cs_priest' }, -- prete
--    { identifier = 'steam:11000011b922100', ped = 'a_c_shepherd' }, -- MOD mike
--}
--
--for i=1, #Config.User_peds do
--    print(Config.User_peds[i].identifier)
--end