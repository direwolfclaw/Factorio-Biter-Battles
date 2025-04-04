--mewmew one dimensional noise

local math_floor = math.floor

local heights = {
    -57,
    -189,
    -128,
    49,
    -1,
    44,
    201,
    -75,
    -223,
    159,
    -51,
    88,
    -61,
    -206,
    -58,
    246,
    154,
    233,
    53,
    -89,
    -41,
    253,
    -253,
    33,
    -160,
    140,
    -83,
    164,
    -129,
    -67,
    -238,
    6,
    238,
    145,
    85,
    89,
    -207,
    126,
    112,
    175,
    -73,
    -211,
    -76,
    137,
    59,
    151,
    167,
    -81,
    -13,
    225,
    -197,
    -25,
    139,
    -202,
    196,
    199,
    104,
    -50,
    -133,
    -199,
    -233,
    -162,
    -193,
    -117,
    79,
    72,
    39,
    -68,
    -48,
    -108,
    -234,
    -98,
    161,
    0,
    -78,
    37,
    -33,
    -95,
    182,
    -114,
    144,
    -110,
    -243,
    -137,
    -105,
    -217,
    -224,
    125,
    97,
    -190,
    -204,
    173,
    -28,
    186,
    168,
    60,
    152,
    91,
    -47,
    -27,
    -107,
    -10,
    -21,
    -142,
    -181,
    -201,
    -183,
    160,
    -209,
    90,
    -135,
    142,
    -123,
    -185,
    65,
    -30,
    -26,
    242,
    -157,
    177,
    -141,
    -44,
    -138,
    113,
    -92,
    17,
    -192,
    245,
    -215,
    45,
    208,
    111,
    248,
    235,
    134,
    211,
    -96,
    -19,
    68,
    108,
    84,
    114,
    -94,
    -251,
    -195,
    29,
    129,
    -102,
    181,
    -70,
    119,
    -125,
    -221,
    86,
    80,
    -118,
    179,
    -255,
    -170,
    176,
    106,
    192,
    209,
    221,
    -145,
    -3,
    130,
    247,
    -194,
    34,
    77,
    -228,
    188,
    75,
    -11,
    25,
    -147,
    -69,
    71,
    -46,
    -136,
    -130,
    227,
    -198,
    95,
    82,
    178,
    -101,
    249,
    -79,
    -8,
    131,
    241,
    -208,
    153,
    -131,
    117,
    166,
    -212,
    78,
    -168,
    223,
    -32,
    98,
    -164,
    162,
    -100,
    -163,
    -148,
    -177,
    -9,
    -55,
    -240,
    -52,
    -5,
    61,
    -161,
    237,
    -120,
    -236,
    21,
    10,
    42,
    243,
    170,
    -246,
    -2,
    18,
    128,
    -40,
    -31,
    92,
    3,
    194,
    -167,
    105,
    -150,
    -65,
    148,
    156,
    -225,
    138,
    -126,
    -82,
    23,
    -169,
    28,
    -200,
    133,
    236,
    -242,
    -250,
    -77,
    180,
    -7,
    43,
    -182,
    121,
    -172,
    -106,
    205,
    -66,
    -205,
    174,
    40,
    -38,
    200,
    210,
    -247,
    48,
    76,
    -90,
    226,
    -72,
    55,
    24,
    -140,
    -93,
    244,
    189,
    -60,
    -159,
    -122,
    -191,
    47,
    185,
    -15,
    -121,
    204,
    240,
    -84,
    229,
    100,
    38,
    74,
    -186,
    -144,
    20,
    127,
    31,
    27,
    213,
    -146,
    183,
    150,
    8,
    -116,
    -174,
    157,
    73,
    96,
    -104,
    -248,
    63,
    -91,
    -99,
    203,
    122,
    -153,
    217,
    -23,
    -166,
    1,
    132,
    -171,
    116,
    163,
    -86,
    -188,
    -87,
    -112,
    158,
    -39,
    -214,
    -63,
    141,
    -103,
    -49,
    202,
    -241,
    70,
    16,
    218,
    2,
    67,
    -53,
    66,
    -254,
    206,
    212,
    -24,
    -18,
    -109,
    93,
    50,
    -62,
    -12,
    -203,
    -244,
    -127,
    155,
    -165,
    219,
    -119,
    -179,
    -37,
    169,
    51,
    -143,
    -226,
    215,
    32,
    250,
    191,
    171,
    -249,
    -230,
    146,
    -20,
    228,
    207,
    -178,
    184,
    -173,
    143,
    239,
    -152,
    -59,
    26,
    -14,
    -139,
    30,
    -235,
    -184,
    195,
    118,
    19,
    -115,
    -176,
    11,
    -34,
    56,
    -132,
    -220,
    197,
    165,
    -17,
    172,
    220,
    -187,
    -232,
    -22,
    187,
    -35,
    -134,
    254,
    -216,
    52,
    36,
    252,
    46,
    -245,
    14,
    5,
    123,
    57,
    -158,
    224,
    83,
    -149,
    -111,
    -45,
    69,
    -210,
    54,
    -156,
    4,
    7,
    149,
    -175,
    102,
    216,
    -29,
    -227,
    22,
    -85,
    -252,
    -239,
    -180,
    -231,
    136,
    193,
    99,
    198,
    -219,
    214,
    64,
    -80,
    110,
    41,
    230,
    87,
    15,
    -97,
    -4,
    58,
    231,
    -71,
    12,
    -154,
    62,
    109,
    135,
    -6,
    124,
    35,
    -218,
    101,
    115,
    94,
    190,
    -124,
    -229,
    222,
    -16,
    -74,
    -222,
    147,
    255,
    -213,
    13,
    -237,
    -42,
    120,
    234,
    9,
    -36,
    -155,
    -54,
    -113,
    -56,
    -88,
    251,
    -196,
    81,
    107,
    -64,
    -43,
    -151,
    232,
    103,
}

local function get_noise(x, seed)
    x = x + seed
    local index = math_floor(x % 255) + 1
    local h1 = heights[index]
    local h2 = heights[index + 1]
    if not h2 then
        h2 = heights[1]
    end

    local floaty = (x - math_floor(x))
    if not floaty then
        return h1
    end

    local vector = h2 - h1
    local vector_pos = vector * floaty
    vector_pos = vector_pos * (vector_pos / vector)

    local n = h1 + vector_pos

    n = n / 255

    return n
end

local function testnoise()
    local surface = game.surfaces[1]
    local seed = math.random(1, 1000000)
    for x = -256, 256, 1 do
        local noise = get_noise(x / 64, seed)
        local entity = surface.create_entity({ name = 'stone-wall', position = { x, noise * 32 }, force = 'player' })
        rendering.draw_text({
            text = math.round(noise, 4),
            surface = surface,
            target = entity,
            color = { 0, 255, 0 },
            scale = 0.88,
            font = default,
            orientation = 0.75,
        })
    end
end

return get_noise
