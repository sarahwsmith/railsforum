class PostsController < ApplicationController
    
        def emojify(context)
          h(context).to_str.gsub(/:([\w+-]+):/) do |match|
            if emoji = Emoji.find_by_alias($1)
              %(<img alt="#$1" src="#{image_path("emoji/#{emoji.image_filename}")}" style="vertical-align:middle" width="20" height="20" />)
            else
              match
            end
          end.html_safe if context.present?
        end
      

    def index
        @posts = Post.all.order("created_at DESC")
    end

    def new
        @post = current_user.posts.build
    end

    def create
        
        params[:context] = emojify(params[:context])
        @post = current_user.posts.build(post_params)
        
        if @post.save
            redirect_to @post
        else
            render 'new'
        end

    end

    def show
    end

    def edit
    end

    def destroy
        @post.destroy
        redirect_to root_path
    end

    def update
        if @post.update(post_params)
            redirect_to @post
        else
            render 'edit'
        end
    end

    
    def post_params
        params.require(:post).permit(:title, :context)
    end


    private

    def find_post
        @post = Post.find(params[:id])
    end


    before_action :find_post, only: [:show, :edit, :update, :destroy]
end
