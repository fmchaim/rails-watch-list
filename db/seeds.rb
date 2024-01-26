require 'json'
require 'net/http'

# Fetch data from the API
url = URI("https://api.themoviedb.org/3/movie/popular?api_key=cc98716933e99e2f65df2a5ca87680ba")
movies_json = Net::HTTP.get(url)
movies = JSON.parse(movies_json)

# Create lists
lists = ['Drama', 'Comedy', 'Classic', 'To rewatch']
lists.each do |list_name|
  List.create!(name: list_name)
end

# Create movies and bookmarks
movies["results"].each do |movie|
  created_movie = Movie.create!(
    title: movie["title"],
    overview: movie["overview"] || "Overview not available.",
    poster_url: "https://image.tmdb.org/t/p/w500#{movie["poster_path"]}",
    rating: movie["vote_average"]
  )

    # Create a bookmark for each movie in each list
    List.all.each do |list|
      Bookmark.create!(
        comment: "This is a comment.",
        movie: created_movie,
        list: list
      )
    end
    puts "Created successfully!"
  end
