get 'ws-get-cities', to:'user#ws_get_cities', as:"ws_get_cities"
get 'ws-get-states', to:'user#ws_get_states', as:'ws_get_states'
get 'ws-get-car-models', to:'user#ws_get_car_models', as:'ws_get_car_models'
get 'get-filtered-cars', to:'user#get_filtered_cars', as: 'get-filtered-cars'
post 'ws-upload-user-cover-pic', to: 'user#ws_user_cover_pic_upload', as:'ws_upload_user_cover_pic'
post 'ws-upload-user-profile-pic', to: 'user#ws_user_profile_pic_upload', as:'ws_upload_user_profile_pic'
