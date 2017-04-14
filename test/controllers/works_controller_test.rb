require "test_helper"

describe WorksController do
  describe "index" do
    it "responds successfully" do
      Work.count.must_be :>, 0
      get works_path
      must_respond_with :success # success -  http status code
    end
    it "still responds successfully when there are no works " do
      Work.destroy_all
      get works_path
      must_respond_with :success
    end
  end  # end of index block
  describe "show" do
    it "shows a work that exists" do
      w = Work.first
      get work_path(w)
      must_respond_with :success
    end
    it "return a 404 not found status when work is not exist" do
      work_id = Work.last.id + 1
      get work_path(work_id) # sending request
      must_respond_with :not_found #checking respond
    end
  end # end of show block
  describe "new" do
    it "responds successfully " do
      get new_work_path
      must_respond_with :success
    end
  end #end of new block
  describe "create" do
    it "adds a work to the database" do
      work_data = {work: {category: "movie", title: "test title",creator: "creator test", publication_year: "1111", description: "description goes here" }}
      post works_path, params: work_data
      must_redirect_to movies_path
    end
    it "rerenders new work form if work is invalid" do
      work_data = {work: {title: "test titwle"}}
      post works_path, params: work_data
      must_respond_with :bad_request
    end
  end # end of create block

  describe "show_albums" do
    it "succesessfully shows a list of  albums " do
      get albums_path
      must_respond_with :success
    end
  end # end of show albums block
  describe "show_books" do
    it "succesessfully shows a list of  books " do
      get books_path
      must_respond_with :success
    end
  end # end of show books block
  describe "show_movies" do
    it "succesessfully shows a list of  movies " do
      get movies_path
      must_respond_with :success
    end
  end # end of show movies block

  describe "edit" do
    it "responds successfully " do
      work_id = Work.all.sample.id
      get edit_work_path(work_id)
      must_respond_with :success
    end
  end # end of edit block

  describe "update" do
    it "updates a work in the database" do
      w = Work.first
      work_data = {work: w.attributes}
      work_data[:work][:title] = "test change"
      patch work_path(w.id), params: work_data
      must_redirect_to work_path(w.id)
    end
    it "rerenders new edit work form if work is invalid" do
      w = Work.first
      work_data = {work: w.attributes}
      work_data[:work][:title] = "Can't Buy a Thrill"
      patch work_path(w.id), params: work_data

      must_respond_with :bad_request
    end
  end # end of edit block

  describe "destroy" do
    it " successfully deletes from database" do
      w = Work.create!(category: "movie", title: "test title",creator: "creator test", publication_year: "1111", description: "description goes here" )
      delete work_path(w.id)
      must_redirect_to movies_path
    end
    it "after deletion, work doesn't exist anymore" do
      w = works(:royal_scam)
      delete work_path(w.id)
      Work.find_by(title: "test title").must_equal nil
    
    end
  end # end of edit block

    describe "upvote" do
      it " redirects back after creating new vote " do
        w = works(:royal_scam)
        u = User.create!(username: "nanana", date_of_joining: "12/01/2016")
        vote = Vote.create!(work: w, user: u)
        post upvote_path(w.id)
        must_redirect_to work_path(w.id)
      end

      # it "" do
      #   w = works(:royal_scam)
      #   result = w.votes.length
      #   u = User.create!(username: "asdf", date_of_joining: "31/01/2017")
      #   vote = Vote.create!(work: w, user: u)
      #   w.votes.length.must_equal result + 1
      # end
    end # end of upvote block
    describe "downvote" do
      it " redirects back after deleting vote " do
        w = works(:royal_scam)
        u = User.create!(username: "nanana", date_of_joining: "12/01/2016")
        vote = Vote.create!(work: w, user: u)
        delete downvote_path(w.id)
        must_redirect_to work_path(w.id)
      end

    end # end of upvote block

end # end of class
