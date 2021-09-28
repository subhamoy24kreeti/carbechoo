User.seed(:id,
  {id: 1, first_name:'john', last_name: 'Doe', email:'john.doe@admin.com', password:'Pass@123',role:'admin'},
  {id: 2, first_name:'jmmy', last_name: 'johonson', email:'jmmy.johnson@gmail.com', password:'Pass@123',role:'seller'},
  {id: 3, first_name:'martin', last_name: 'luis', email:'martin.luis@gmail.com', password:'Pass@123',role:'buyer'}
)

'''Country.seed(:id,
 {id: 1, name: "India"},
 {id: 2, name: "Bangla desh"},
 {id: 3, name: "china"}
)
State.seed(:id,
  {id: 1, country_id: 1, name: "West Bengal"},
  {id: 2, country_id: 1, name: "Bihar"},
  {id: 3, country_id: 1, name: "Karnatak"},
)

City.seed(:id,
  {id: 1, state_id: 1, name: "Kharagpur" },
  {id: 2, state_id: 1, name: "Kolkata"},
  {id: 3, state_id: 1, name: "Durgapur"}
)
Brand.seed(:id,
  {id: 1, brand_name: "TATA MOTORS"}
)

CarModel.seed(:id,
  {id: 1, brand_id: 1, name: "XUV-200"}
)'''

